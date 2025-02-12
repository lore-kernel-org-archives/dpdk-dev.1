Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9CAC02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 18:50:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9A0842D55;
	Wed, 12 Feb 2025 19:50:37 +0100 (CET)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 by mails.dpdk.org (Postfix) with ESMTP id C3296400D5
 for <dev@dpdk.org>; Wed, 12 Feb 2025 19:50:35 +0100 (CET)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-309027e11a5so114661fa.0
 for <dev@dpdk.org>; Wed, 12 Feb 2025 10:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1739386235; x=1739991035; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2NJWJbP5J3XMnfQU/7bWU5vB7PpXYhdtc+H+HjffNU4=;
 b=Z97WZsKySCClh0759kXVgChxL7lt8zicY7a/JOjvwtLXjan3IZOcS35pg82poGhaSo
 iElQjwT9f1xyRFgeNRlHIYM9iIihAkJpkXX+zcrovSsC4cMeZawR66Vv4EAljjKCx/AQ
 2chD5oq+xXfW8/5KP0RPoBkKmTpTFsVzPwc0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739386235; x=1739991035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2NJWJbP5J3XMnfQU/7bWU5vB7PpXYhdtc+H+HjffNU4=;
 b=fxT/EWMoty3XG/wHy+R9BCd4VMq6o22kT/f4ynuTfJgez9na/evg74dC4O+rN721s6
 G8tXXiW9g4p+5h2K8PgSFLmUg+Vgtu7rAkkhcujJOJU8GGu/rwy9zPy87/2aPYImEW8F
 frJULMeqWbzeGqqFDwQ1pc+AXL2uTuhcUnjdD/zp4psca0y/kX8FBUO8OpS3ETt8WxI8
 buUvtG+rn5z/TovB4V5Hv27igAll+pUK0y8P0S26/S7AIQk2VgKpXeEj16ScNXSNXClN
 8FBp0dH67vbIGBOdMkG6vyNFrGIaTZ1ttDUqQKWOZpyIh+63HvRETPby5GLKeMln5/vN
 3sEQ==
X-Gm-Message-State: AOJu0YyY3F+J72rDTTru9pyHiEdwfZGcIj2hXeIuUwTbw7aKY/EDF1Sq
 eogWNaCi13rYQ6iCHQAZ85XWjJ9AeqzybBfmJLtHcFbV4qRf8yzvFAMMxASJaLqUUuesapjTVH3
 V3qNFbzThEmTVNi2RVuAax0W7uBQjX3s5oi0G+A==
X-Gm-Gg: ASbGncv6QP99myeCrK00EifAAsavt8gAKFTPdZErYJhLTIHmxLpZPilkCkaBhFgEGoJ
 tnrqrmVmDT1dJDCYn6tZn7Lce3uFWvYEIj1j99lQUF8IwJUJsp5PDqWH+5QrwxYwFzy44jI4sq1
 AyaPE9T/ggcBZgrgR1wRvMDTYwu0xwGrE=
X-Google-Smtp-Source: AGHT+IErOkwRckKHh7rBoHQoM4e35SA/M3THFq4AL/xKSokqfqfoM/DECfnKqgeNFUUp+o5hB6nZ7gzdjhy4/PQDkm8=
X-Received: by 2002:a2e:be27:0:b0:308:f2a5:6e01 with SMTP id
 38308e7fff4ca-309036f70f4mr6160821fa.10.1739386234995; Wed, 12 Feb 2025
 10:50:34 -0800 (PST)
MIME-Version: 1.0
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
 <20250203151613.2436570-6-luca.vizzarro@arm.com>
In-Reply-To: <20250203151613.2436570-6-luca.vizzarro@arm.com>
From: Nicholas Pratte <npratte@iol.unh.edu>
Date: Wed, 12 Feb 2025 13:50:23 -0500
X-Gm-Features: AWEUYZmI76yrDeRPk-Gmy_h-3Zjn27Kl59YhpaVQRiD1b3_tkS6j41c5DhYvtDE
Message-ID: <CAKXZ7eg5XgMDS4n+CmNNEcBUS7=eKTMovRE_eymggzq0xR=23w@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] dts: add runtime status
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Patrick Robb <probb@iol.unh.edu>, 
 Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Reviewed-by: Nicholas Pratte <npratte@iol.unh.edu>

On Mon, Feb 3, 2025 at 10:17=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.co=
m> wrote:
>
> Add a new module which defines the global runtime status of DTS and the
> distinct execution stages and steps.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> ---
>  doc/api/dts/framework.status.rst |  8 ++++
>  doc/api/dts/index.rst            |  1 +
>  dts/framework/logger.py          | 36 ++++--------------
>  dts/framework/status.py          | 64 ++++++++++++++++++++++++++++++++
>  4 files changed, 81 insertions(+), 28 deletions(-)
>  create mode 100644 doc/api/dts/framework.status.rst
>  create mode 100644 dts/framework/status.py
>
> diff --git a/doc/api/dts/framework.status.rst b/doc/api/dts/framework.sta=
tus.rst
> new file mode 100644
> index 0000000000..07277b5301
> --- /dev/null
> +++ b/doc/api/dts/framework.status.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +status - DTS status definitions
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: framework.status
> +   :members:
> +   :show-inheritance:
> diff --git a/doc/api/dts/index.rst b/doc/api/dts/index.rst
> index 534512dc17..cde603576c 100644
> --- a/doc/api/dts/index.rst
> +++ b/doc/api/dts/index.rst
> @@ -29,6 +29,7 @@ Modules
>     framework.test_suite
>     framework.test_result
>     framework.settings
> +   framework.status
>     framework.logger
>     framework.parser
>     framework.utils
> diff --git a/dts/framework/logger.py b/dts/framework/logger.py
> index d2b8e37da4..7b1c8e6637 100644
> --- a/dts/framework/logger.py
> +++ b/dts/framework/logger.py
> @@ -13,37 +13,17 @@
>  """
>
>  import logging
> -from enum import auto
>  from logging import FileHandler, StreamHandler
>  from pathlib import Path
>  from typing import ClassVar
>
> -from .utils import StrEnum
> +from framework.status import PRE_RUN, State
>
>  date_fmt =3D "%Y/%m/%d %H:%M:%S"
>  stream_fmt =3D "%(asctime)s - %(stage)s - %(name)s - %(levelname)s - %(m=
essage)s"
>  dts_root_logger_name =3D "dts"
>
>
> -class DtsStage(StrEnum):
> -    """The DTS execution stage."""
> -
> -    #:
> -    pre_run =3D auto()
> -    #:
> -    test_run_setup =3D auto()
> -    #:
> -    test_suite_setup =3D auto()
> -    #:
> -    test_suite =3D auto()
> -    #:
> -    test_suite_teardown =3D auto()
> -    #:
> -    test_run_teardown =3D auto()
> -    #:
> -    post_run =3D auto()
> -
> -
>  class DTSLogger(logging.Logger):
>      """The DTS logger class.
>
> @@ -55,7 +35,7 @@ class DTSLogger(logging.Logger):
>      a new stage switch occurs. This is useful mainly for logging per tes=
t suite.
>      """
>
> -    _stage: ClassVar[DtsStage] =3D DtsStage.pre_run
> +    _stage: ClassVar[State] =3D PRE_RUN
>      _extra_file_handlers: list[FileHandler] =3D []
>
>      def __init__(self, *args, **kwargs):
> @@ -75,7 +55,7 @@ def makeRecord(self, *args, **kwargs) -> logging.LogRec=
ord:
>              record: The generated record with the stage information.
>          """
>          record =3D super().makeRecord(*args, **kwargs)
> -        record.stage =3D DTSLogger._stage
> +        record.stage =3D str(DTSLogger._stage)
>          return record
>
>      def add_dts_root_logger_handlers(self, verbose: bool, output_dir: st=
r) -> None:
> @@ -110,7 +90,7 @@ def add_dts_root_logger_handlers(self, verbose: bool, =
output_dir: str) -> None:
>
>          self._add_file_handlers(Path(output_dir, self.name))
>
> -    def set_stage(self, stage: DtsStage, log_file_path: Path | None =3D =
None) -> None:
> +    def set_stage(self, state: State, log_file_path: Path | None =3D Non=
e) -> None:
>          """Set the DTS execution stage and optionally log to files.
>
>          Set the DTS execution stage of the DTSLog class and optionally a=
dd
> @@ -120,15 +100,15 @@ def set_stage(self, stage: DtsStage, log_file_path:=
 Path | None =3D None) -> None:
>          the other one is a machine-readable log file with extra debug in=
formation.
>
>          Args:
> -            stage: The DTS stage to set.
> +            state: The DTS execution state to set.
>              log_file_path: An optional path of the log file to use. This=
 should be a full path
>                  (either relative or absolute) without suffix (which will=
 be appended).
>          """
>          self._remove_extra_file_handlers()
>
> -        if DTSLogger._stage !=3D stage:
> -            self.info(f"Moving from stage '{DTSLogger._stage}' to stage =
'{stage}'.")
> -            DTSLogger._stage =3D stage
> +        if DTSLogger._stage !=3D state:
> +            self.info(f"Moving from stage '{DTSLogger._stage}' " f"to st=
age '{state}'.")
> +            DTSLogger._stage =3D state
>
>          if log_file_path:
>              self._extra_file_handlers.extend(self._add_file_handlers(log=
_file_path))
> diff --git a/dts/framework/status.py b/dts/framework/status.py
> new file mode 100644
> index 0000000000..4a59aa50e6
> --- /dev/null
> +++ b/dts/framework/status.py
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 Arm Limited
> +
> +"""Running status of DTS.
> +
> +This module contains the definitions that represent the different states=
 of execution within DTS.
> +"""
> +
> +from enum import auto
> +from typing import NamedTuple
> +
> +from .utils import StrEnum
> +
> +
> +class Stage(StrEnum):
> +    """Execution stage."""
> +
> +    #:
> +    PRE_RUN =3D auto()
> +    #:
> +    TEST_RUN =3D auto()
> +    #:
> +    TEST_SUITE =3D auto()
> +    #:
> +    TEST_CASE =3D auto()
> +    #:
> +    POST_RUN =3D auto()
> +
> +
> +class InternalState(StrEnum):
> +    """Internal state of the current execution stage."""
> +
> +    #:
> +    BEGIN =3D auto()
> +    #:
> +    SETUP =3D auto()
> +    #:
> +    RUN =3D auto()
> +    #:
> +    TEARDOWN =3D auto()
> +    #:
> +    END =3D auto()
> +
> +
> +class State(NamedTuple):
> +    """Representation of the DTS execution state."""
> +
> +    #:
> +    stage: Stage
> +    #:
> +    state: InternalState
> +
> +    def __str__(self) -> str:
> +        """A formatted name."""
> +        name =3D self.stage.value.lower()
> +        if self.state is not InternalState.RUN:
> +            return f"{name}_{self.state.value.lower()}"
> +        return name
> +
> +
> +#: A ready-made pre-run DTS state.
> +PRE_RUN =3D State(Stage.PRE_RUN, InternalState.RUN)
> +#: A ready-made post-run DTS state.
> +POST_RUN =3D State(Stage.POST_RUN, InternalState.RUN)
> --
> 2.43.0
>
