# pyright: reportMissingImports=false
from kitty.boss import Boss


def mod(boss: Boss):
    boss.call_remote_control(boss.active_window, ('close-tab', '--match', 'all'))
    boss.call_remote_control(boss.active_window, ('launch', '--type', 'tab', '--tab-title', 'editor', '--cwd', '~/Documents/FAMAF/modelos/'))
    boss.call_remote_control(boss.active_window, ('send-text', 'source .venv/bin/activate\nclear\n'))
def mod(boss: Boss):
    boss.call_remote_control(boss.active_window, ('close-tab', '--match', 'all'))
    boss.call_remote_control(boss.active_window, ('launch', '--type', 'tab', '--tab-title', 'run', '--cwd', '~/Documents/FAMAF/modelos/'))
    boss.call_remote_control(boss.active_window, ('send-text', 'source .venv/bin/activate\nclear\n'))
    boss.call_remote_control(boss.active_window, ('launch', '--type', 'tab', '--tab-title', 'editor', '--cwd', '~/Documents/FAMAF/modelos/'))
    boss.call_remote_control(boss.active_window, ('send-text', 'source .venv/bin/activate\nclear\n'))
    boss.call_remote_control(boss.active_window, ('action', 'move_tab_forward'))


def cp(boss: Boss):
    boss.call_remote_control(boss.active_window, ('close-tab', '--match', 'all'))
    boss.call_remote_control(boss.active_window, ('launch', '--type', 'tab', '--tab-title', 'local-run', '--cwd', '~/Documents/FAMAF/computacion-paralela/'))
    boss.call_remote_control(boss.active_window, ('launch', '--type', 'tab', '--tab-title', 'atom', '--cwd', '~/Documents/FAMAF/computacion-paralela/'))
    boss.call_remote_control(boss.active_window, ('send-text', 'ssh atom\n'))
    boss.call_remote_control(boss.active_window, ('launch', '--type', 'tab', '--tab-title', 'local-editor', '--cwd', '~/Documents/FAMAF/computacion-paralela/'))
    boss.call_remote_control(boss.active_window, ('action', 'move_tab_forward'))


sessions_list = {
    'mod': mod,
    'cp': cp,
}


def main(args: list[str]) -> str:
    available_sessions = ', '.join(list(sessions_list.keys()))

    print(f'Available sessions: {available_sessions}')
    print('Press enter or input invalid session to cancel')
    answer = input('Select a session: ')
    
    return answer


def handle_result(args: list[str], answer: str, target_window_id: int, boss: Boss) -> None:
    session_function = sessions_list[answer]
    
    if session_function is not None:
        session_function(boss)
