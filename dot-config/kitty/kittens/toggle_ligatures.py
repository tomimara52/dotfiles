# pyright: reportMissingImports=false
from kitty.boss import Boss

def main(args: list[str]) -> str:
    pass

from kittens.tui.handler import result_handler
@result_handler(no_ui=True)
def handle_result(args: list[str], answer: str, target_window_id: int, boss: Boss) -> None:
    window = boss.active_window
    strategy = window.screen.disable_ligatures

    if strategy == 'never':
        window.screen.disable_ligatures = 'always'
    else:
        window.screen.disable_ligatures = 'never'
