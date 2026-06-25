Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856E0CDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 02:34:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1AEF402A3;
	Thu, 25 Jun 2026 04:34:51 +0200 (CEST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46]) by mails.dpdk.org (Postfix) with ESMTP id DDDDB40279
 for <dev@dpdk.org>; Thu, 25 Jun 2026 04:34:49 +0200 (CEST)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5aa7a7ad4d3so1417910e87.1
 for <dev@dpdk.org>; Wed, 24 Jun 2026 19:34:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782354889; cv=none;
 d=google.com; s=arc-20260327;
 b=JRkovb+qe+PFawrxBjLaa34mMGaIoTQw6NZku9yseiqKJT9HioCFse0nzKJ8OhN6pz
 e1ltQ48+dxML3agDx52EARvgG5Qy8QzvMswJd8AL3dqSMnrZ7HjOiv/bTxYjR8VlKbai
 8SW3/YPhCIxpHCt9RkHnGdXWTdANKh3a1Ob5HfEv1rgTDG10RU1v//S97BNxGlgBsYfJ
 ptHaHcseIgJUsuZ/lGNwmzsaienKT25FhQF+IMnpXpGWK36C2TIuYAKtEwD9L2SnYuDH
 iAC2tvyoKxhfBeBJQ/MIkNwKYw2TqvSwDbgCHikQy4Y8dxCdGgbrJBrwd04t3eiEuM1+
 WLPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sS89BwRiSWuen/hdijqsFHUu5Lmt0NmJ9kPYB2Tx/jM=;
 fh=GTdaKSNkTw0gFM1kDxavzM674tPnhtg8HzGtbeeCRFI=;
 b=OJbQB15avjmn2oohzFZGb/B/wbgoPvcMwHzZoI01N3RlvHHIYM58B9AvHQXyu4xmEj
 gtCLBp1UkY/17GYzx0k+5e7jNYmhXOjiR+joNVON2F6u47nYFaki4Xk+7QZ2F6Mkp6KT
 M2xnqlij0MTlPpVrkQtNN8dkU6mxr9nZZVSlgCbpD9YhwoMp+S74AoFDeoriuxq/7JRs
 fDcw/f97PVgP15G+AA19cKt+8HD+xSzI1HYIxykG1wo/JZIsxFc7rjTgeGwP24VfIIZU
 HV+6bQh2k1Zyy0AJX+daNewASu6kmIaFPJ2hzm6mK3yRViMKSGhEdklCSQ1nqvEZWUWg
 aSew==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782354889; x=1782959689; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sS89BwRiSWuen/hdijqsFHUu5Lmt0NmJ9kPYB2Tx/jM=;
 b=N025OX0bDthwX5scEMKX3ETtZDipNiigatslLg5NLcC1LLoRdSvtiBOl47Yl3kcuoo
 oqvwWdaJV7r0m2wwVqVf0N/B9RvMMTmmVI4sjowJhD2AgoC1cTzkG54Krk9VjxK4xcYR
 XavWWgNayiy6XL/nj7YiS2r8RWg4LsSMGEOmGtYV6t34SBSOiPiIEizAAYm6Ne/kkRoC
 q637MTP/LGryhSEyRCIOmGAechGl8gtjw6yUHHbW7rH2dls4PnLseevptlBcCtbgyBOy
 XXdfgRYu4RrttoEXOgtXWkpG2NsKQtUR59pQtHdpdCDgnmC32O1l8O3v/cyLoZmiJbzt
 hHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782354889; x=1782959689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sS89BwRiSWuen/hdijqsFHUu5Lmt0NmJ9kPYB2Tx/jM=;
 b=TcIeSVL94D1JXV/D9aT9UuEwSVt4MR++yX/RQEP10PB1Hpjo3qHTbib2Xi5ZWkkx4Q
 x+ea/TzdY8NCG4sgKHSWevaFMwDaZcW7rucK4WwL35fVDiJq2nxHVt72vdbRKnY0j0QE
 mpv85CE4FYTTTmPIMOOD1l3LHEFDmHl2HZqIG/EkFVuTA+MTiFANgU7wZTXoHYBWT+fE
 6PJ6BjhA24qEEJIA2iUEr+2hvUT90hsz1iq/JGpqqZJ9XneV4jCv2qbEqsRf9+QBfAKn
 zKmZ0D/yqkT2yGi+S14NGLc4kcpT6s1RSNx/m8woYgiWZmt9DnVIakjuv2FbpbMBuEMm
 /o3A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoYlAhGdQU7kvEB9AgBUVAMSmeNfEPpqtkBLFMkhKpCm8n+E6IlD364a9YYYgmFSWZMoM0=@dpdk.org
X-Gm-Message-State: AOJu0YxUbfjEBh8zJmxYUc3qfMQ2NUK63CiJot/LIT21bRPkT8Ft0cYr
 mxQnN5VJv8/HQza8Dy0AqXR0uNElYcc3uduT8IJZb7bOyi7UfCUGbRg118tZLRLRZIHqUB5wNxf
 93RoGwQCOZuirMtvEMoIEuNldLaKM6T0=
X-Gm-Gg: AfdE7cni0dyCZNalIIaNhPmn+XUwkddPQLnGH0BIzOOcGdhjFEAv79h+gIvRUpFTcAm
 rkVqACbig4D2HMDibsNuo8tukP0gpks7hR0Vmxfvk5aSyr+izF+2SO/4mggnTeJfIGgc/2E22wz
 yqLa/pHS7lajJhpSRlsiiHL6r27X6+uwZWDaOH/UJqO6e5wUSnWKcV4M1DOS2JZ2GwbiGidgGYO
 cXrR/KdEJQT7l/QFE4hJK/GDKMnVosUcX3akcZhDMFgfMWfwaKm4A/BkM1YTJnkRBtdo9Md1m8x
 IVW4p7cp1041DwP1i+CqBjr/WyEOauunNed6TLF0eY4Pi02++LGoG90n
X-Received: by 2002:a05:6512:238c:b0:5ad:6941:9e42 with SMTP id
 2adb3069b0e04-5aea1f28de0mr150597e87.4.1782354888717; Wed, 24 Jun 2026
 19:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260522154637.952588-1-knimoji@iol.unh.edu>
 <20260622170223.1152746-1-knimoji@iol.unh.edu>
In-Reply-To: <20260622170223.1152746-1-knimoji@iol.unh.edu>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Wed, 24 Jun 2026 22:34:36 -0400
X-Gm-Features: AVVi8CfY1P4RStFGnFzXIxI5lAXGixQ7AnknkVrUGUjv034Ivf9SF1Z8ZNS98ow
Message-ID: <CAK6DuxvoMGyBmGSu-6WYnC2bQqV=SeqoOME=m=Xs-5UgRv+=hg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dts: add code coverage reporting to DTS
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, abailey@iol.unh.edu, 
 ahassick@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000017aa306550ad6de"
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

--000000000000017aa306550ad6de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 1:02=E2=80=AFPM Koushik Bhargav Nimoji <knimoji@iol=
.unh.edu>
wrote:

> Previously, DTS had no code coverage. This patch adds a command line
> argument in order to build DPDK with code coverage enabled. This allows
> users to create and view code coverage reports of what code and functions
> were called during a DTS run.
>
> Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
> ---
> v2:
>     *Fixed error in lcov/gcov tool detection
> v3:
>     *Fixed type hints and error message typos
> ---
>  .mailmap                                      |  1 +
>  doc/guides/tools/dts.rst                      | 15 +++++++++++++
>  dts/README.md                                 |  5 +++++
>  dts/framework/remote_session/dpdk.py          | 19 ++++++++++++++++
>  .../remote_session/remote_session.py          |  5 ++++-
>  dts/framework/settings.py                     | 10 +++++++++
>  dts/framework/testbed_model/os_session.py     | 10 +++++++++
>  dts/framework/testbed_model/posix_session.py  | 22 +++++++++++++++++++
>  dts/framework/utils.py                        |  8 +++++++
>  9 files changed, 94 insertions(+), 1 deletion(-)
>
> diff --git a/.mailmap b/.mailmap
> index e052b85213..a1209150ad 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -877,6 +877,7 @@ Klaus Degner <kd@allegro-packets.com>
>  Kommula Shiva Shankar <kshankar@marvell.com>
>  Konstantin Ananyev <konstantin.ananyev@huawei.com> <
> konstantin.v.ananyev@yandex.ru>
>  Konstantin Ananyev <konstantin.ananyev@huawei.com> <
> konstantin.ananyev@intel.com>
> +Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
>  Krishna Murthy <krishna.j.murthy@intel.com>
>  Krzysztof Galazka <krzysztof.galazka@intel.com>
>  Krzysztof Kanas <kkanas@marvell.com> <krzysztof.kanas@caviumnetworks.com=
>
> diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
> index 5b9a348016..a838a317ee 100644
> --- a/doc/guides/tools/dts.rst
> +++ b/doc/guides/tools/dts.rst
> @@ -352,6 +352,10 @@ DTS is run with ``main.py`` located in the ``dts``
> directory using the ``poetry
>       --precompiled-build-dir DIR_NAME
>                             [DTS_PRECOMPILED_BUILD_DIR] Define the
> subdirectory under the DPDK tree root directory or tarball where the pre-
>                             compiled binaries are located. (default: None=
)
> +     --code-coverage       Builds DPDK on the SUT node with code coverag=
e
> enabled. Generates a code coverage report which can be found on
> +                           the local filesystem at
> dts/output/coverage_reports/meson-logs/coveragereport/index.html, or the
> specified output
>

at the DTS execution host's local filesystem

I realize you are presumably concating what gcov/lcov gives you but can the
dts/output/coverage_reports/meson-logs/coveragereport/index.html, path be
shortened? Seems like 2-3 of those middle dir names can be dropped hah. Not
a big deal if left as is for any reason.


> +                           directory. To use code coverage, please ensur=
e
> lcov v1.15 and gcov v8.0 or higher (included in gcc package) are
> +                           installed on the SUT node.
>
>
>  The brackets contain the names of environment variables that set the sam=
e
> thing.
> @@ -367,6 +371,17 @@ Results are stored in the output dir by default
>  which be changed with the ``--output-dir`` command line argument.
>  The results contain basic statistics of passed/failed test cases and DPD=
K
> version.
>
> +Code Coverage
> +~~~~~~~~~~~~~
> +
> +DTS has the ablilty to track code usage during test runs, and generate a=
n
> HTML
>

I'm sure it's obvious to most readers what coverage we are talking about
here, but why not just explicitly say DTS can generate coverage reports
which show the code coverage % for DPDK libraries and drivers touched
during the testsuite(s) execution? It never hurts to be extra clear. :)

VERY IMPORTANT: You need to explain what the code coverage behavior is. Is
it a code coverage report per testrun? or per testsuite?

If it is per testrun, what happens if we use a prebuilt DPDK dir? Then do
coverage stats bleed over between runs because the build dir is preserved?
(happy to talk about this tomorrow if I'm not phrasing it clearly).

+coverage report with that data. This can be done by using the
> "--code-coverage"
> +CLI parameter when running DTS.
> +
> +To use code coverage, please make sure the following dependencies are
> available
> +on the SUT node:
> +- lcov v1.15
>

code says 1.15 or greater


> +- gcov v8.0 or greater (included in gcc package)
>
>  Contributing to DTS
>  -------------------
> diff --git a/dts/README.md b/dts/README.md
> index d257b7a167..51f824e077 100644
> --- a/dts/README.md
> +++ b/dts/README.md
> @@ -64,6 +64,11 @@ $ poetry run ./main.py
>  These commands will give you a bash shell inside a docker container
>  with all DTS Python dependencies installed.
>
> +# Code Coverage
> +
> +To generate code coverage reports, ensure the SUT has lcov v1.15 and gco=
v
> v8.0 or greater
> +installed, and that DTS is run using the '--code-coverage' argument.
>

Not that I'm opposed, but it is interesting to me that we are exposing this
toggle as a flag but not as a test_run.yaml option. I was about to suggest
adding a test_run.yaml boolean field for it but... maybe we need to relax
on the amount of fields we put in there. It might be better for some of the
more "infrequently used" options to be flag only, for readability reasons.
Happy to defer to your judgement here.


> +
>  ## Visual Studio Code
>
>  Usage of VScode devcontainers is NOT required for developing on DTS and
> running DTS,
> diff --git a/dts/framework/remote_session/dpdk.py
> b/dts/framework/remote_session/dpdk.py
> index c3575cfcaf..865f97f6ca 100644
> --- a/dts/framework/remote_session/dpdk.py
> +++ b/dts/framework/remote_session/dpdk.py
> @@ -29,6 +29,7 @@
>  from framework.logger import DTSLogger, get_dts_logger
>  from framework.params.eal import EalParams
>  from framework.remote_session.remote_session import CommandResult
> +from framework.settings import SETTINGS
>  from framework.testbed_model.cpu import LogicalCore, LogicalCoreCount,
> LogicalCoreList, lcore_filter
>  from framework.testbed_model.node import Node
>  from framework.testbed_model.os_session import OSSession
> @@ -107,7 +108,22 @@ def teardown(self) -> None:
>          """Teardown the DPDK build on the target node.
>
>          Removes the DPDK tree and/or build directory/tarball depending o=
n
> the configuration.
> +        If code coverage is enabled, the coverage report and .info file
> are generated and
> +        copied onto the local filesystem before teardown.
>          """
> +        if SETTINGS.code_coverage:
> +            report_folder =3D PurePath(self.remote_dpdk_build_dir /
> "meson-logs")
> +            output_dir =3D SETTINGS.output_dir
> +            Path(output_dir).mkdir(parents=3DTrue, exist_ok=3DTrue)
> +
> +            coverage_status =3D
> self._session.generate_coverage_report(self.remote_dpdk_build_dir)
> +            if coverage_status:
> +                self._session.copy_dir_from(report_folder, output_dir)
> +                self._logger.info(
> +                    "Coverage HTML report generated, "
> +                    f"available at
> {output_dir}/meson-logs/coveragereports/index.html"
> +                )
> +
>          match self.config.dpdk_location:
>              case LocalDPDKTreeLocation():
>
>  self._node.main_session.remove_remote_dir(self.remote_dpdk_tree_path)
> @@ -272,6 +288,9 @@ def _build_dpdk(self) -> None:
>          else:
>              meson_args =3D MesonArgs(default_library=3D"static", libdir=
=3D"lib")
>
> +        if SETTINGS.code_coverage:
> +            meson_args._add_arg("-Db_coverage=3Dtrue")
> +
>          self._session.build_dpdk(
>              self._env_vars,
>              meson_args,
> diff --git a/dts/framework/remote_session/remote_session.py
> b/dts/framework/remote_session/remote_session.py
> index 158325bb7f..d2440dc2d8 100644
> --- a/dts/framework/remote_session/remote_session.py
> +++ b/dts/framework/remote_session/remote_session.py
> @@ -252,7 +252,10 @@ def copy_from(self, source_file: str | PurePath,
> destination_dir: str | Path) ->
>              destination_dir: The directory path on the local filesystem
> where the `source_file`
>                  will be saved.
>          """
> -        self.session.get(str(source_file), str(destination_dir))
> +        source_file =3D PurePath(source_file)
> +        destination_dir =3D Path(destination_dir)
> +        local_path =3D destination_dir / source_file.name
> +        self.session.get(str(source_file), str(local_path))
>
>      def copy_to(self, source_file: str | Path, destination_dir: str |
> PurePath) -> None:
>          """Copy a file from local filesystem to the remote Node.
> diff --git a/dts/framework/settings.py b/dts/framework/settings.py
> index b08373b7ea..7df535bd84 100644
> --- a/dts/framework/settings.py
> +++ b/dts/framework/settings.py
> @@ -159,6 +159,8 @@ class Settings:
>      re_run: int =3D 0
>      #:
>      random_seed: int | None =3D None
> +    #:
> +    code_coverage: bool =3D False
>
>
>  SETTINGS: Settings =3D Settings()
> @@ -489,6 +491,14 @@ def _get_parser() -> _DTSArgumentParser:
>      )
>      _add_env_var_to_action(action)
>
> +    action =3D parser.add_argument(
> +        "--code-coverage",
> +        action=3D"store_true",
> +        default=3DFalse,
> +        help=3D"Used to build DPDK with code coverage enabled.",
> +    )
> +    _add_env_var_to_action(action)
> +
>      return parser
>
>
> diff --git a/dts/framework/testbed_model/os_session.py
> b/dts/framework/testbed_model/os_session.py
> index 2c267afed1..742b074948 100644
> --- a/dts/framework/testbed_model/os_session.py
> +++ b/dts/framework/testbed_model/os_session.py
> @@ -480,6 +480,16 @@ def build_dpdk(
>              timeout: Wait at most this long in seconds for the build
> execution to complete.
>          """
>
> +    @abstractmethod
> +    def generate_coverage_report(self, remote_build_dir: PurePath | None=
)
> -> bool:
> +        """Generates a code coverage report for a DTS run.
> +
> +        Args:
> +            remote_build_dir: The remote DPDK build directory
> +        Returns:
> +            Whether the coverage report was able to be created or not.
> +        """
> +
>      @abstractmethod
>      def get_dpdk_version(self, version_path: str | PurePath) -> str:
>          """Inspect the DPDK version on the remote node.
> diff --git a/dts/framework/testbed_model/posix_session.py
> b/dts/framework/testbed_model/posix_session.py
> index dec952685a..d18ce27de2 100644
> --- a/dts/framework/testbed_model/posix_session.py
> +++ b/dts/framework/testbed_model/posix_session.py
> @@ -295,6 +295,28 @@ def build_dpdk(
>          except RemoteCommandExecutionError as e:
>              raise DPDKBuildError(f"DPDK build failed when doing
> '{e.command}'.")
>
> +    def generate_coverage_report(self, remote_build_dir: PurePath | None=
)
> -> bool:
> +        """Overrides
> :meth:`~.os_session.OSSession.generate_coverage_report`."""
> +        command_result =3D self.send_command(r"lcov --version | grep -oP
> '\d+\.\d+'")
> +        lcov_version =3D float(
> +            command_result.stdout if command_result.return_code =3D=3D 0=
 and
> command_result else -1
> +        )
> +        command_result =3D self.send_command(
> +            r"gcov --version | head -n 1 | grep -oP '\d+\.\d+' | tail -n
> 1"
> +        )
> +        gcov_version =3D float(
> +            command_result.stdout if command_result.return_code =3D=3D 0=
 and
> command_result else -1
> +        )
> +
> +        if lcov_version >=3D 1.15 and gcov_version >=3D 8.0:
> +            self.send_command(f"ninja -C {remote_build_dir}
> coverage-html", timeout=3D600)
> +            return True
> +        else:
> +            self._logger.info(
> +                "Unable to generate code coverage report, ensure lcov
> v1.15 and at least gcov v8.0"
> +            )
> +            return False
> +
>      def get_dpdk_version(self, build_dir: str | PurePath) -> str:
>          """Overrides :meth:`~.os_session.OSSession.get_dpdk_version`."""
>          out =3D self.send_command(f"cat {self.join_remote_path(build_dir=
,
> 'VERSION')}", verify=3DTrue)
> diff --git a/dts/framework/utils.py b/dts/framework/utils.py
> index 9917ffbfaa..38da88cd9c 100644
> --- a/dts/framework/utils.py
> +++ b/dts/framework/utils.py
> @@ -125,6 +125,14 @@ def __str__(self) -> str:
>          """The actual args."""
>          return " ".join(f"{self._default_library}
> {self._dpdk_args}".split())
>
> +    def _add_arg(self, arg: str):
> +        """Used to add a meson build argument to the DPDK build.
>

Nit but rephrase to "Adds an argument to the Meson setup command"


> +
> +        Args:
> +            arg: The meson build argument to be added.
> +        """
> +        self._dpdk_args =3D self._dpdk_args + " " + arg
> +
>
>  class TarCompressionFormat(StrEnum):
>      """Compression formats that tar can use.
> --
> 2.54.0
>
>
Reviewed-by: Patrick Robb <patrickrobb1997@gmail.com>

--000000000000017aa306550ad6de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 22,=
 2026 at 1:02=E2=80=AFPM Koushik Bhargav Nimoji &lt;<a href=3D"mailto:knimo=
ji@iol.unh.edu">knimoji@iol.unh.edu</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Previously, DTS had no code coverage. Th=
is patch adds a command line<br>
argument in order to build DPDK with code coverage enabled. This allows<br>
users to create and view code coverage reports of what code and functions<b=
r>
were called during a DTS run.<br>
<br>
Signed-off-by: Koushik Bhargav Nimoji &lt;<a href=3D"mailto:knimoji@iol.unh=
.edu" target=3D"_blank">knimoji@iol.unh.edu</a>&gt;<br>
---<br>
v2:<br>
=C2=A0 =C2=A0 *Fixed error in lcov/gcov tool detection<br>
v3:<br>
=C2=A0 =C2=A0 *Fixed type hints and error message typos=C2=A0 =C2=A0 <br>
---<br>
=C2=A0.mailmap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 1 +<br>
=C2=A0doc/guides/tools/dts.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 15 +++++++++++++<br>
=C2=A0dts/README.md=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +++=
++<br>
=C2=A0dts/framework/remote_session/dpdk.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 19 ++++++++++++++++<br>
=C2=A0.../remote_session/remote_session.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 5 ++++-<br>
=C2=A0dts/framework/settings.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 +++++++++<br>
=C2=A0dts/framework/testbed_model/os_session.py=C2=A0 =C2=A0 =C2=A0| 10 +++=
++++++<br>
=C2=A0dts/framework/testbed_model/posix_session.py=C2=A0 | 22 +++++++++++++=
++++++<br>
=C2=A0dts/framework/utils.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 +++++++<br>
=C2=A09 files changed, 94 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/.mailmap b/.mailmap<br>
index e052b85213..a1209150ad 100644<br>
--- a/.mailmap<br>
+++ b/.mailmap<br>
@@ -877,6 +877,7 @@ Klaus Degner &lt;<a href=3D"mailto:kd@allegro-packets.c=
om" target=3D"_blank">kd@allegro-packets.com</a>&gt;<br>
=C2=A0Kommula Shiva Shankar &lt;<a href=3D"mailto:kshankar@marvell.com" tar=
get=3D"_blank">kshankar@marvell.com</a>&gt;<br>
=C2=A0Konstantin Ananyev &lt;<a href=3D"mailto:konstantin.ananyev@huawei.co=
m" target=3D"_blank">konstantin.ananyev@huawei.com</a>&gt; &lt;<a href=3D"m=
ailto:konstantin.v.ananyev@yandex.ru" target=3D"_blank">konstantin.v.ananye=
v@yandex.ru</a>&gt;<br>
=C2=A0Konstantin Ananyev &lt;<a href=3D"mailto:konstantin.ananyev@huawei.co=
m" target=3D"_blank">konstantin.ananyev@huawei.com</a>&gt; &lt;<a href=3D"m=
ailto:konstantin.ananyev@intel.com" target=3D"_blank">konstantin.ananyev@in=
tel.com</a>&gt;<br>
+Koushik Bhargav Nimoji &lt;<a href=3D"mailto:knimoji@iol.unh.edu" target=
=3D"_blank">knimoji@iol.unh.edu</a>&gt;<br>
=C2=A0Krishna Murthy &lt;<a href=3D"mailto:krishna.j.murthy@intel.com" targ=
et=3D"_blank">krishna.j.murthy@intel.com</a>&gt;<br>
=C2=A0Krzysztof Galazka &lt;<a href=3D"mailto:krzysztof.galazka@intel.com" =
target=3D"_blank">krzysztof.galazka@intel.com</a>&gt;<br>
=C2=A0Krzysztof Kanas &lt;<a href=3D"mailto:kkanas@marvell.com" target=3D"_=
blank">kkanas@marvell.com</a>&gt; &lt;<a href=3D"mailto:krzysztof.kanas@cav=
iumnetworks.com" target=3D"_blank">krzysztof.kanas@caviumnetworks.com</a>&g=
t;<br>
diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst<br>
index 5b9a348016..a838a317ee 100644<br>
--- a/doc/guides/tools/dts.rst<br>
+++ b/doc/guides/tools/dts.rst<br>
@@ -352,6 +352,10 @@ DTS is run with ``main.py`` located in the ``dts`` dir=
ectory using the ``poetry<br>
=C2=A0 =C2=A0 =C2=A0 --precompiled-build-dir DIR_NAME<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 [DTS_PRECOMPILED_BUILD_DIR] Define the subdirector=
y under the DPDK tree root directory or tarball where the pre-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 compiled binaries are located. (default: None)<br>
+=C2=A0 =C2=A0 =C2=A0--code-coverage=C2=A0 =C2=A0 =C2=A0 =C2=A0Builds DPDK =
on the SUT node with code coverage enabled. Generates a code coverage repor=
t which can be found on<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0the local filesystem at dts/output/coverage_reports=
/meson-logs/coveragereport/index.html, or the specified output<br></blockqu=
ote><div><br></div><div>at the DTS execution host&#39;s local filesystem</d=
iv><div><br></div><div>I realize you are presumably concating what gcov/lco=
v gives you but can the=C2=A0<span style=3D"background-color:transparent">d=
ts/output/coverage_reports/me</span><span style=3D"background-color:transpa=
rent">son-logs/coveragereport/index.</span><span style=3D"background-color:=
transparent">html, path be shortened? Seems like 2-3 of those middle dir na=
mes can be dropped hah. Not a big deal if left as is for any reason.</span>=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0directory. To use code coverage, please ensure lcov=
 v1.15 and gcov v8.0 or higher (included in gcc package) are<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0installed on the SUT node.<br>
<br>
<br>
=C2=A0The brackets contain the names of environment variables that set the =
same thing.<br>
@@ -367,6 +371,17 @@ Results are stored in the output dir by default<br>
=C2=A0which be changed with the ``--output-dir`` command line argument.<br>
=C2=A0The results contain basic statistics of passed/failed test cases and =
DPDK version.<br>
<br>
+Code Coverage<br>
+~~~~~~~~~~~~~<br>
+<br>
+DTS has the ablilty to track code usage during test runs, and generate an =
HTML<br></blockquote><div><br></div><div>I&#39;m sure it&#39;s obvious to m=
ost readers what coverage we are talking about here, but why not just expli=
citly say DTS can generate coverage reports which show the code coverage % =
for DPDK libraries and drivers touched during the testsuite(s) execution? I=
t never hurts to be extra clear. :)</div><div>=C2=A0</div><div>VERY IMPORTA=
NT: You need to explain what the code coverage behavior is. Is it a code co=
verage report per testrun? or per testsuite?</div><div><br></div><div>If it=
 is per testrun, what happens if we use a prebuilt DPDK dir? Then do covera=
ge stats bleed over between runs because the build dir is preserved? (happy=
 to talk about this tomorrow if I&#39;m not phrasing it clearly).</div><div=
><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+coverage report with that data. This can be done by using the &quot;--code=
-coverage&quot;<br>
+CLI parameter when running DTS.<br>
+<br>
+To use code coverage, please make sure the following dependencies are avai=
lable<br>
+on the SUT node:<br>
+- lcov v1.15<br></blockquote><div><br></div><div>code says 1.15 or greater=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+- gcov v8.0 or greater (included in gcc package)<br>
<br>
=C2=A0Contributing to DTS<br>
=C2=A0-------------------<br>
diff --git a/dts/README.md b/dts/README.md<br>
index d257b7a167..51f824e077 100644<br>
--- a/dts/README.md<br>
+++ b/dts/README.md<br>
@@ -64,6 +64,11 @@ $ poetry run ./main.py<br>
=C2=A0These commands will give you a bash shell inside a docker container<b=
r>
=C2=A0with all DTS Python dependencies installed.<br>
<br>
+# Code Coverage<br>
+<br>
+To generate code coverage reports, ensure the SUT has lcov v1.15 and gcov =
v8.0 or greater<br>
+installed, and that DTS is run using the &#39;--code-coverage&#39; argumen=
t.<br></blockquote><div><br></div><div>Not that I&#39;m opposed, but it is =
interesting to me that we are exposing this toggle as a flag but not as a t=
est_run.yaml option. I was about to suggest adding a test_run.yaml boolean =
field for it but... maybe we need to relax on the amount of fields we put i=
n there. It might be better for some of the more &quot;infrequently used&qu=
ot; options to be flag only, for readability=C2=A0reasons. Happy to defer t=
o your judgement here.</div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
+<br>
=C2=A0## Visual Studio Code<br>
<br>
=C2=A0Usage of VScode devcontainers is NOT required for developing on DTS a=
nd running DTS,<br>
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_se=
ssion/dpdk.py<br>
index c3575cfcaf..865f97f6ca 100644<br>
--- a/dts/framework/remote_session/dpdk.py<br>
+++ b/dts/framework/remote_session/dpdk.py<br>
@@ -29,6 +29,7 @@<br>
=C2=A0from framework.logger import DTSLogger, get_dts_logger<br>
=C2=A0from framework.params.eal import EalParams<br>
=C2=A0from framework.remote_session.remote_session import CommandResult<br>
+from framework.settings import SETTINGS<br>
=C2=A0from framework.testbed_model.cpu import LogicalCore, LogicalCoreCount=
, LogicalCoreList, lcore_filter<br>
=C2=A0from framework.testbed_model.node import Node<br>
=C2=A0from framework.testbed_model.os_session import OSSession<br>
@@ -107,7 +108,22 @@ def teardown(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Teardown the DPDK build=
 on the target node.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Removes the DPDK tree and/or build direct=
ory/tarball depending on the configuration.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 If code coverage is enabled, the coverage repo=
rt and .info file are generated and<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 copied onto the local filesystem before teardo=
wn.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if SETTINGS.code_coverage:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 report_folder =3D PurePath(self.=
remote_dpdk_build_dir / &quot;meson-logs&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 output_dir =3D SETTINGS.output_d=
ir<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Path(output_dir).mkdir(parents=
=3DTrue, exist_ok=3DTrue)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 coverage_status =3D self._sessio=
n.generate_coverage_report(self.remote_dpdk_build_dir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if coverage_status:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._session.copy=
_dir_from(report_folder, output_dir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._<a href=3D"h=
ttp://logger.info" rel=3D"noreferrer" target=3D"_blank">logger.info</a>(<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;Coverage HTML report generated, &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;available at {output_dir}/meson-logs/coveragereports/index.html&quot;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0match self.config.dpdk_location:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case LocalDPDKTreeLocation(=
):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._node.ma=
in_session.remove_remote_dir(self.remote_dpdk_tree_path)<br>
@@ -272,6 +288,9 @@ def _build_dpdk(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0meson_args =3D MesonArgs(de=
fault_library=3D&quot;static&quot;, libdir=3D&quot;lib&quot;)<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if SETTINGS.code_coverage:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 meson_args._add_arg(&quot;-Db_co=
verage=3Dtrue&quot;)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._session.build_dpdk(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._env_vars,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0meson_args,<br>
diff --git a/dts/framework/remote_session/remote_session.py b/dts/framework=
/remote_session/remote_session.py<br>
index 158325bb7f..d2440dc2d8 100644<br>
--- a/dts/framework/remote_session/remote_session.py<br>
+++ b/dts/framework/remote_session/remote_session.py<br>
@@ -252,7 +252,10 @@ def copy_from(self, source_file: str | PurePath, desti=
nation_dir: str | Path) -&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0destination_dir: The direct=
ory path on the local filesystem where the `source_file`<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0will be saved=
.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.session.get(str(source_file), str(destina=
tion_dir))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 source_file =3D PurePath(source_file)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 destination_dir =3D Path(destination_dir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 local_path =3D destination_dir / <a href=3D"ht=
tp://source_file.name" rel=3D"noreferrer" target=3D"_blank">source_file.nam=
e</a><br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.session.get(str(source_file), str(local_p=
ath))<br>
<br>
=C2=A0 =C2=A0 =C2=A0def copy_to(self, source_file: str | Path, destination_=
dir: str | PurePath) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Copy a file from local =
filesystem to the remote Node.<br>
diff --git a/dts/framework/settings.py b/dts/framework/settings.py<br>
index b08373b7ea..7df535bd84 100644<br>
--- a/dts/framework/settings.py<br>
+++ b/dts/framework/settings.py<br>
@@ -159,6 +159,8 @@ class Settings:<br>
=C2=A0 =C2=A0 =C2=A0re_run: int =3D 0<br>
=C2=A0 =C2=A0 =C2=A0#:<br>
=C2=A0 =C2=A0 =C2=A0random_seed: int | None =3D None<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 code_coverage: bool =3D False<br>
<br>
<br>
=C2=A0SETTINGS: Settings =3D Settings()<br>
@@ -489,6 +491,14 @@ def _get_parser() -&gt; _DTSArgumentParser:<br>
=C2=A0 =C2=A0 =C2=A0)<br>
=C2=A0 =C2=A0 =C2=A0_add_env_var_to_action(action)<br>
<br>
+=C2=A0 =C2=A0 action =3D parser.add_argument(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--code-coverage&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 action=3D&quot;store_true&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DFalse,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 help=3D&quot;Used to build DPDK with code cove=
rage enabled.&quot;,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 _add_env_var_to_action(action)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0return parser<br>
<br>
<br>
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/test=
bed_model/os_session.py<br>
index 2c267afed1..742b074948 100644<br>
--- a/dts/framework/testbed_model/os_session.py<br>
+++ b/dts/framework/testbed_model/os_session.py<br>
@@ -480,6 +480,16 @@ def build_dpdk(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timeout: Wait at most this =
long in seconds for the build execution to complete.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
+=C2=A0 =C2=A0 @abstractmethod<br>
+=C2=A0 =C2=A0 def generate_coverage_report(self, remote_build_dir: PurePat=
h | None) -&gt; bool:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Generates a code coverage re=
port for a DTS run.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remote_build_dir: The remote DPD=
K build directory<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Whether the coverage report was =
able to be created or not.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0@abstractmethod<br>
=C2=A0 =C2=A0 =C2=A0def get_dpdk_version(self, version_path: str | PurePath=
) -&gt; str:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Inspect the DPDK versio=
n on the remote node.<br>
diff --git a/dts/framework/testbed_model/posix_session.py b/dts/framework/t=
estbed_model/posix_session.py<br>
index dec952685a..d18ce27de2 100644<br>
--- a/dts/framework/testbed_model/posix_session.py<br>
+++ b/dts/framework/testbed_model/posix_session.py<br>
@@ -295,6 +295,28 @@ def build_dpdk(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except RemoteCommandExecutionError as e:<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise DPDKBuildError(f&quot=
;DPDK build failed when doing &#39;{e.command}&#39;.&quot;)<br>
<br>
+=C2=A0 =C2=A0 def generate_coverage_report(self, remote_build_dir: PurePat=
h | None) -&gt; bool:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Overrides :meth:`~.os_sessio=
n.OSSession.generate_coverage_report`.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 command_result =3D self.send_command(r&quot;lc=
ov --version | grep -oP &#39;\d+\.\d+&#39;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 lcov_version =3D float(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command_result.stdout if command=
_result.return_code =3D=3D 0 and command_result else -1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 command_result =3D self.send_command(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r&quot;gcov --version | head -n =
1 | grep -oP &#39;\d+\.\d+&#39; | tail -n 1&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gcov_version =3D float(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command_result.stdout if command=
_result.return_code =3D=3D 0 and command_result else -1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if lcov_version &gt;=3D 1.15 and gcov_version =
&gt;=3D 8.0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(f&quot;ninja -=
C {remote_build_dir} coverage-html&quot;, timeout=3D600)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._<a href=3D"http://logger.i=
nfo" rel=3D"noreferrer" target=3D"_blank">logger.info</a>(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Unable to ge=
nerate code coverage report, ensure lcov v1.15 and at least gcov v8.0&quot;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def get_dpdk_version(self, build_dir: str | PurePath) -=
&gt; str:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Overrides :meth:`~.os_s=
ession.OSSession.get_dpdk_version`.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0out =3D self.send_command(f&quot;cat {sel=
f.join_remote_path(build_dir, &#39;VERSION&#39;)}&quot;, verify=3DTrue)<br>
diff --git a/dts/framework/utils.py b/dts/framework/utils.py<br>
index 9917ffbfaa..38da88cd9c 100644<br>
--- a/dts/framework/utils.py<br>
+++ b/dts/framework/utils.py<br>
@@ -125,6 +125,14 @@ def __str__(self) -&gt; str:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;The actual args.&quot;&=
quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &quot; &quot;.join(f&quot;{self._d=
efault_library} {self._dpdk_args}&quot;.split())<br>
<br>
+=C2=A0 =C2=A0 def _add_arg(self, arg: str):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Used to add a meson build ar=
gument to the DPDK build.<br></blockquote><div><br></div><div>Nit but rephr=
ase to &quot;Adds an argument to the Meson setup command&quot;</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arg: The meson build argument to=
 be added.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._dpdk_args =3D self._dpdk_args + &quot; &=
quot; + arg<br>
+<br>
<br>
=C2=A0class TarCompressionFormat(StrEnum):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Compression formats that tar can use.=
<br>
-- <br>
2.54.0<br>
<br></blockquote><div><br></div><div>Reviewed-by: Patrick Robb &lt;<a href=
=3D"mailto:patrickrobb1997@gmail.com">patrickrobb1997@gmail.com</a>&gt;=C2=
=A0</div></div></div>

--000000000000017aa306550ad6de--
