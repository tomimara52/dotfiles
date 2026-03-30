# pyright: reportMissingImports=false
from kitty.boss import Boss


def lengform(boss: Boss):
    boss.call_remote_control(boss.active_window, ("close-tab", "--match", "all"))
    boss.call_remote_control(
        boss.active_window,
        ("launch", "--type", "tab", "--cwd", "~/Documents/FAMAF/lengform"),
    )
    boss.call_remote_control(boss.active_window, ("send-text", "xpdf *.pdf &\n"))
    boss.call_remote_control(boss.active_window, ("send-text", "disown\n"))


def logica(boss: Boss):
    boss.call_remote_control(boss.active_window, ("close-tab", "--match", "all"))
    boss.call_remote_control(
        boss.active_window,
        ("launch", "--type", "tab", "--cwd", "~/Documents/FAMAF/logica"),
    )
    boss.call_remote_control(boss.active_window, ("send-text", "xpdf *.pdf &\n"))
    boss.call_remote_control(boss.active_window, ("send-text", "disown\n"))


def fisica(boss: Boss):
    boss.call_remote_control(boss.active_window, ("close-tab", "--match", "all"))
    boss.call_remote_control(
        boss.active_window,
        ("launch", "--type", "tab", "--cwd", "~/Documents/FAMAF/fisica"),
    )
    boss.call_remote_control(boss.active_window, ("send-text", "xpdf *.pdf &\n"))
    boss.call_remote_control(boss.active_window, ("send-text", "disown\n"))


sessions_list = {
    "logica": logica,
    "fisica": fisica,
    "lengform": lengform,
}


def main(args: list[str]) -> str:
    available_sessions = ", ".join(list(sessions_list.keys()))

    print(f"Available sessions: {available_sessions}")
    print("Press enter or input invalid session to cancel")
    answer = input("Select a session: ")

    return answer


def handle_result(
    args: list[str], answer: str, target_window_id: int, boss: Boss
) -> None:
    session_function = sessions_list[answer]

    if session_function is not None:
        session_function(boss)
