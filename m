Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01481C44507
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:16:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 567B540DCF;
	Fri, 17 Jul 2026 11:16:20 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id B247740612
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:16:19 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 2D4CC140005B;
 Fri, 17 Jul 2026 05:16:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Fri, 17 Jul 2026 05:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1784279779; x=1784366179; bh=pLuZwQkbaxbrhsfnrbVyy
 ZeaJKJQcfPUeV1eGZARJ60=; b=ipLb9ilLcaEIDR/MOnFZd2nASGwE0z/TOLQOQ
 dMAbhSwIijW2YBrAgYlMlb9agsWgpNT9xH1CyChEMiz86dg6XeG/gSBU4qBcsWme
 GcR0em3DYXZeqSzc0UY3AF9nwNBQKOQ4r408tN9jeppHE+B3qAIfn4n8f/OHkE5v
 KT8lKEIG42K6UQQGEJehUn7CPN53bHFLkLF1i7fqT7CtGjd/Jbb5FIyL++Z0IiRG
 WAxesilZjMZ3qBIAGVVK2TAdcg71cKKdOYctFDIg58tXVwRluPKctAAZmY9oN1oV
 cCzslqmKXejcA1qjvllVWntUkQB5xjJaOGAjZaS8G2y/e4myA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1784279779; x=1784366179; bh=pLuZwQkbaxbrhsfnrbVyyZeaJKJQcfPUeV1
 eGZARJ60=; b=eNwAJsLjwP8ng8Zzycn4+R18kC/gUsK+muBJ1Xv0dJpWmarhfq1
 ieui/8JybaBBfAaWvQ0cEjZ4HFG6011r8Y/4k1mfNYQe057iT4G2msAshyt4DkO6
 U9rkEE7zNzXxHs7k1bWZD1UrdV9BgP2D8getMCf9JErRP4jAbux7OFer5zJcYuIA
 0nYiBYlzevOo4Ks34spUipqUyeVUpc3jsbJSi0rOusPhFzelWDMJJKl1TsPuzcNP
 z3nuuH4fFWkhbXcGiiRp2fRMm6qoBwUj8s9RDO56Is57Rg/WS0pg7YFzzGYUAZiW
 nLV9PQ1rC+tYAt88ChgLXO/g4sGpYLalqEQ==
X-ME-Sender: <xms:4vJZaioo3KYKv3kibJXuReB8shlSbCKNuB9R6YbOoL90Dpg3Fj0DOA>
 <xme:4vJZagxXHFUlHNDQweVXtHAqgI_zvKUQXIYt19rGvSSt18gPP34HvkiVAMneEzR0M
 AVGi3ti3QzOBXqnzaDVYPjjvoGmRBFSGkSGBelLY3CgG6P58xZ8Bw>
X-ME-Received: <xmr:4vJZavLhKMjBwuhTCaGoM8EGqBTY-EwGUu3-B2x9uRAsPs8iNottAYT2V5P8JMVJKWBvgCcWJreFTBonPF9RqtA>
X-ME-Proxy-Cause: dmFkZTFUj4k431mDtP1L4K6Zm0wLO1WsydUkpnmBnteNj2LDCaP9HNfgJS4i/HaG2v6K2s
 25qmLxCf5UclqyykS+u/yV84UiO1jsPuKf/95NN8b8EZPRaandppFicyo6MvUpqRxtzq0H
 d7cn5dMGiMHs+DKdwfOStyAACzZUmZ5gsB2XNfKH4PiQm3V3PAlB6aatkZG5FqM2KIO8Ka
 VnsPPJgaYHL4uA+9pzFVNpQp4T33jW9AnH8tX2brsukcNCc6kh/TuEiA2FGRYWSpnEYFGP
 oqcX4MRzczaRUWTuGIXcsxvMyoRnRl9L+Mfr8GU4XzayFL9xG6GOB9uyu7REAuR8GXx9R2
 rmz9GBWi8pB5c2ak98ynWcAArbDIiMB6TYDEwpNM6NFezShfTlOfvyWxHUy6eRKM5zr7sz
 vvDNtkFLSJ2023och/MPJ7W71J7JOFsDqeQyOj1/BHgDJOt21MKcMyxtL/OsuwY/84hDWW
 Tyll7jEAT7zILoKEoD7R/MexfytwqUJBcbmGhIUGV5VdPxQJdKhMVNcKYRushfnUmeebmv
 B010CGCBMTL6V2iZy20k7tUlWBurTBFqorhY6pD8VPRIjEZhNutfvBk7R41Nynhp2Dxrik
 zSiRAWPBClqzhse5t34qHEFlQFnHW3QhOOrzzvnRwBPyUKzZkSbbh9PwP8SQ
X-ME-Proxy: <xmx:4vJZaqJgrn7xRdjASY88jHmZ2PUiBxpEWg2VC20N9wOxzX0rVfn3Ow>
 <xmx:4vJZasu-UpoVWQGoJO2KAMlPqLoaMGxhy9QQ3dd7X4ogTK7i5Ok8xQ>
 <xmx:4vJZanSs6dJpJNR_CnjkwGLyDIcHiDZyCeuIJsMqm_ei6Gqi6QDWQg>
 <xmx:4vJZaiPbn_6hF3AJ2a20AjcDxiWTVMWFRE9HAH5UIbcw4HCdrYCvjQ>
 <xmx:4_JZaoWRjhFE7268ct_nSz5RUPDVp7YnQKGT_uSkEV8PwVxhdGrRG3Se>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 05:16:17 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Robin Jarry <rjarry@redhat.com>, Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH] usertools/telemetry: load aliases from config directory
Date: Fri, 17 Jul 2026 11:16:03 +0200
Message-ID: <20260717091603.1492650-1-thomas@monjalon.net>
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

The default path of the telemetry alias file
was at the top level of the home directory.

Load aliases from the DPDK configuration directory instead,
using $XDG_CONFIG_HOME/dpdk/telemetry_aliases
or $HOME/.config/dpdk/telemetry_aliases.

Keep --alias-file for users who want to provide an explicit path.

Fixes: 410d498412e4 ("usertools/telemetry: support aliases for long commands")

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/howto/telemetry.rst |  6 ++++--
 usertools/dpdk-telemetry.py    | 23 +++++++++++++++++------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/doc/guides/howto/telemetry.rst b/doc/guides/howto/telemetry.rst
index b3f25c1113..fdaede1987 100644
--- a/doc/guides/howto/telemetry.rst
+++ b/doc/guides/howto/telemetry.rst
@@ -154,9 +154,11 @@ and query information using the telemetry client python script.
 
      The telemetry script can load aliases at startup from::
 
-        $HOME/.dpdk_telemetry_aliases
+        $XDG_CONFIG_HOME/dpdk/telemetry_aliases
+
+     If ``XDG_CONFIG_HOME`` is not set, ``$HOME/.config/dpdk/telemetry_aliases`` is used.
+     A custom path can also be provided via the ``--alias-file`` script flag.
 
-     or from a custom path provided via the ``--alias-file`` script flag.
      Each alias entry must be in ``alias=command`` format.
      Empty lines and lines starting with ``#`` are ignored.
 
diff --git a/usertools/dpdk-telemetry.py b/usertools/dpdk-telemetry.py
index 20627b596b..e575f269cb 100755
--- a/usertools/dpdk-telemetry.py
+++ b/usertools/dpdk-telemetry.py
@@ -22,7 +22,7 @@
 DEFAULT_PREFIX = "rte"
 CMDS = []
 ALIASES = {}
-ALIAS_FILE = ".dpdk_telemetry_aliases"
+ALIAS_FILE = "telemetry_aliases"
 MAX_ALIAS_EXPANSIONS = 32
 
 BASIC_HELP_TEXT = """Basic usage:
@@ -46,19 +46,30 @@
 """
 
 
+def get_default_alias_path():
+    config_home = os.environ.get("XDG_CONFIG_HOME")
+    if config_home:
+        return os.path.join(config_home, "dpdk", ALIAS_FILE)
+
+    home = os.environ.get("HOME")
+    if not home:
+        return None
+
+    return os.path.join(home, ".config", "dpdk", ALIAS_FILE)
+
+
 def load_aliases(alias_path=None):
-    """Load aliases from $HOME/.dpdk_telemetry_aliases or a custom path if provided"""
+    """Load aliases from the config directory or a custom path if provided"""
     aliases = {}
     if alias_path and not os.path.isfile(alias_path):
         print("Warning: alias file {} not found, skipping".format(alias_path), file=sys.stderr)
         return aliases
 
     if not alias_path:
-        home = os.environ.get("HOME")
-        if not home:
+        alias_path = get_default_alias_path()
+        if not alias_path:
             return aliases
 
-        alias_path = os.path.join(home, ALIAS_FILE)
         if not os.path.isfile(alias_path):
             return aliases
 
@@ -434,7 +445,7 @@ def readline_complete(text, state):
 )
 parser.add_argument(
     "--alias-file",
-    help=f"Provide a custom alias file instead of $HOME/{ALIAS_FILE}",
+    help="Provide a custom alias file instead of the default config path",
 )
 parser.add_argument(
     "-i", "--instance", default="0", type=int, help="Provide instance number for DPDK application"
-- 
2.54.0

