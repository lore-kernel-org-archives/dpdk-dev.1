Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBC0CD13DA
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 19:29:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1C624021F;
	Thu, 30 Apr 2026 21:29:35 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id DE992400D6
 for <dev@dpdk.org>; Thu, 30 Apr 2026 21:29:33 +0200 (CEST)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-8eb5ad01402so138200785a.2
 for <dev@dpdk.org>; Thu, 30 Apr 2026 12:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1777577373; x=1778182173; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bmZd87HF5wyC142e8ut5gjKYfWx9WyvoahzDBZTWIEo=;
 b=Utyjbfngap5Cgnm8rTW1mykOX0HwPxTUIXv+96BtASZlv9FK+nKPfRXzrCZasWsGBX
 SvX6ljLKg5O9ySC34vBPrR6W6CcbU2wFGkQrjY+4Fn2/KaUBJvPr1YTdso6vm8Up0RSL
 JnUUSZuTKhnaFft3c5hqKHa1O4MOKLF0F1eO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777577373; x=1778182173;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bmZd87HF5wyC142e8ut5gjKYfWx9WyvoahzDBZTWIEo=;
 b=NfZi4truAKYgeJJwZ5klsUpZLCm1zO2EkktDYUbJ6iaGTDAZeZbz17o8DAnzI4AeZN
 yjqXRorfX26CE6CVyHxK3o1H0sH/ojNaJwC9J/aIoQBxL7bd3h+WzzFm2GGTlKHCaLDN
 PmYLCrDiS2zIbHhZPf/nfhhSe6/EC466wdPLL0i85hPPXiC5BKKRDFBTXeLOEauSjsYV
 NrQgJB1OWVz5OWLg9M+b/U956VJRblKqjmjHoWCFO3cpqPw4/2jrDDSl1Mo2MofRhGuc
 Xtrj8vCzHtLivbOw9zoClFR9wTS8ymTZUPts2gVSgapRA71PCzXMVEETIG8iM0UrJ+ix
 v3cw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+534Qvkpy4LdFZ3WnqaNCe+8FSbajc9uD6SuXlkt/9Z1LWGVm1ySWqV73UdTfPAkkwSOc=@dpdk.org
X-Gm-Message-State: AOJu0YwCLoW4wH8r4qmqzZ7GD3sxgbsFrW9nSUPOOcsFf08PMpwZvyIJ
 0ydyfNwbD4f3J9g+TJ7fDnWXUIlUfPg0631Sv4ut9oF4yWdMQYFo93el8q/OPB04eYA=
X-Gm-Gg: AeBDies8AzNETS6IOo5fI7Y17RlXAOMzkrkT8EJt6lABgOFZAUQWIMELYIW4oQ4I6Qj
 66uLquNRm09Vu4WJXxArXjMZvUW9uP4Qx2uaDOmFzENz9jScdifr45ligQRlXkUehAnKEcd29aO
 w9ftYetAiidEOweWXmuaRehEmh1KOGy+cxR4pcRYprqOxc7B5zpWFcyYwp3/fzUp06V0kGDIdo3
 dH1VIhfu9Vq9rE7SMgrDv+yk/xRiDT7Ad+qp+vNEp6GpaGU2NZtrUKsLev1hzTm6YKigO1QT+kC
 ecG9+ScU/8gR+vlJfpjWXydknJXESc1D9pTN6z5HjBlATiueszeb5plNB6caKkFyq34kT2kMZ2v
 PuxxjwT525ItkGbbLK+DzV7XI15M0Y3DaiiX93hydXSlqv1+S1qWCxzHljIgCMUTSPhzGy9Kw35
 IYqPWzQKrCF2sBrFrkcY2QaRzk2WvkyCbf3L2DjwlRaeMMD27H5E8vqZ9HgjYoSYkKUea2T+sA9
 fWiKm2PjJKZFIaWATRIE/uztTKPiYj18qkc20P+ELL9+xtTL2pS7+ebj8dWD3J1TcRmmv4rJV8Q
 TSBb/o3YYQRdEykVi3ZWvXJJBJVQ0xMNwgk+fwPPdLmCAw==
X-Received: by 2002:ac8:5f47:0:b0:50d:ab9d:33bc with SMTP id
 d75a77b69052e-5102ab34ee4mr64043841cf.8.1777577372963; 
 Thu, 30 Apr 2026 12:29:32 -0700 (PDT)
Received: from d122214.iol.unh.edu ([2606:4100:3880:1220:ff12:f4a1:a541:db45])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5103d206793sm3255951cf.11.2026.04.30.12.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 12:29:32 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com,
	dev@dpdk.org
Cc: abailey@iol.unh.edu, dmarx@iol.unh.edu, lylavoie@iol.unh.edu,
 ahassick@iol.unh.edu, Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [RFC] dts: add code coverage parameter to DTS
Date: Thu, 30 Apr 2026 15:29:11 -0400
Message-ID: <20260430192911.297180-1-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Previously, DTS had no code coverage. This patch adds a command line
argument in order to build DPDK with code coverage enabled. This allows
users to create and view code coverage reports of what code and functions
were called during a DTS run.

Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
---
 .mailmap                             |  1 +
 dts/framework/remote_session/dpdk.py |  4 ++++
 dts/framework/settings.py            | 10 ++++++++++
 dts/framework/utils.py               |  8 ++++++++
 4 files changed, 23 insertions(+)

diff --git a/.mailmap b/.mailmap
index 0e0d83e1c6..3b0ffb689c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -868,6 +868,7 @@ Klaus Degner <kd@allegro-packets.com>
 Kommula Shiva Shankar <kshankar@marvell.com>
 Konstantin Ananyev <konstantin.ananyev@huawei.com> <konstantin.v.ananyev@yandex.ru>
 Konstantin Ananyev <konstantin.ananyev@huawei.com> <konstantin.ananyev@intel.com>
+Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
 Krishna Murthy <krishna.j.murthy@intel.com>
 Krzysztof Galazka <krzysztof.galazka@intel.com>
 Krzysztof Kanas <kkanas@marvell.com> <krzysztof.kanas@caviumnetworks.com>
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index c3575cfcaf..d5813eec00 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -29,6 +29,7 @@
 from framework.logger import DTSLogger, get_dts_logger
 from framework.params.eal import EalParams
 from framework.remote_session.remote_session import CommandResult
+from framework.settings import SETTINGS
 from framework.testbed_model.cpu import LogicalCore, LogicalCoreCount, LogicalCoreList, lcore_filter
 from framework.testbed_model.node import Node
 from framework.testbed_model.os_session import OSSession
@@ -272,6 +273,9 @@ def _build_dpdk(self) -> None:
         else:
             meson_args = MesonArgs(default_library="static", libdir="lib")
 
+        if SETTINGS.code_coverage:
+            meson_args._add_arg("-Db_coverage=true")
+
         self._session.build_dpdk(
             self._env_vars,
             meson_args,
diff --git a/dts/framework/settings.py b/dts/framework/settings.py
index b08373b7ea..7df535bd84 100644
--- a/dts/framework/settings.py
+++ b/dts/framework/settings.py
@@ -159,6 +159,8 @@ class Settings:
     re_run: int = 0
     #:
     random_seed: int | None = None
+    #:
+    code_coverage: bool = False
 
 
 SETTINGS: Settings = Settings()
@@ -489,6 +491,14 @@ def _get_parser() -> _DTSArgumentParser:
     )
     _add_env_var_to_action(action)
 
+    action = parser.add_argument(
+        "--code-coverage",
+        action="store_true",
+        default=False,
+        help="Used to build DPDK with code coverage enabled.",
+    )
+    _add_env_var_to_action(action)
+
     return parser
 
 
diff --git a/dts/framework/utils.py b/dts/framework/utils.py
index 9917ffbfaa..38da88cd9c 100644
--- a/dts/framework/utils.py
+++ b/dts/framework/utils.py
@@ -125,6 +125,14 @@ def __str__(self) -> str:
         """The actual args."""
         return " ".join(f"{self._default_library} {self._dpdk_args}".split())
 
+    def _add_arg(self, arg: str):
+        """Used to add a meson build argument to the DPDK build.
+
+        Args:
+            arg: The meson build argument to be added.
+        """
+        self._dpdk_args = self._dpdk_args + " " + arg
+
 
 class TarCompressionFormat(StrEnum):
     """Compression formats that tar can use.
-- 
2.53.0

