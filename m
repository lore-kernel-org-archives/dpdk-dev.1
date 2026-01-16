Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE3AC982FE
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 21:17:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C22D42E74;
	Fri, 16 Jan 2026 22:17:03 +0100 (CET)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51]) by mails.dpdk.org (Postfix) with ESMTP id 1B38D42E65
 for <dev@dpdk.org>; Fri, 16 Jan 2026 22:17:00 +0100 (CET)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b8708930695so393714466b.3
 for <dev@dpdk.org>; Fri, 16 Jan 2026 13:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768598220;
 x=1769203020; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVKcnIB+251kMwL/P/yHKb8ouAPSOGYZvp3KQ3UwzCw=;
 b=Bjg/fpMCEDxiD//yYBx1gilNJ6ywHJbGvH/9eCGMzzsxV0kqunDRtjWdWOimRKKp47
 17kXAP8Oit7ZI5npWirgJeTuJDXsiFgbzlEQaNnnSpX8wL1yWG809fmmt8DaWZoJ3R16
 Pndzs3C1aOhBvivlhfsWDBZBu6VgLBcUvgUB67su8IgbLvAgacH9y26S4EIrzpp7Ryt3
 emMgRupxge1AO5bcviTAFx7xLB77ZDOC6IlddqWh6liaFYUhkIjksfpCUOxirPycfVB0
 Jc4WWu4Sw2kg3fY3uV4+OFUtoONjGjaonn9XvmE8Usopdh1rH2V/Jkl4MsKFi4HWXL0j
 QkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768598220; x=1769203020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bVKcnIB+251kMwL/P/yHKb8ouAPSOGYZvp3KQ3UwzCw=;
 b=Fe2o+5uAzCNGN47l1QzCbK0sUpBBd0iJxsuknkpbn3Alxa+e1JVWnn5BdacttgQFba
 Rh/RMu5pAP3rAkpr2p2ITyB9JGAX/7CJ4Xw+yNA8haNMJ6VZYDGv2AmAU88ROCVbir+8
 w3wFxs1F5ofdNlh+3Mc7NvPSlGfn40kw0sEJpZVTopWfQNSuz+RigRemZ23h/24vLFbV
 4qafJtG68gIf2Phtpu+ELazSboa0sVWs4wqWNwd+ca3eNb5QrdWhzvqWKfoWZF4zn5wj
 qHZL42WneuaUx0d0tyjXHWMwKLmz2iytwlYEmWLhYK5ZPh0VKwg62howWcWP2qsvmEVr
 RNLg==
X-Gm-Message-State: AOJu0Yx9N9bdS+/Ucf4oCz7Dos7kYn+r3WreouvP38Ng8BNhr0Mr14+4
 5P4yHpbNXMVITtYHmYGcQffidTlThXrONWVcW1ESktU1F5JWzyg7Nk3/+EfKn+IMdTYdRybPWWL
 abxGf
X-Gm-Gg: AY/fxX7WVPXjUZsRkhtFURJt98qyRyH8WCs42bH/74n9zSjEB+VyYcFh3FEE/rEj6ys
 HIxNmSDaRIgIaE/8swNDYW/JFDPPc3iAtcB1y8LmWOkw9IPho5jN11pC8tSizRKlyz9OxGgj4hy
 yLDyAYeFeTr75fiS7O4oxfUAVVcOtAD3csYQCB4JMASkVdznIT368JIcy7JghdfBH4LeKRPzoga
 YmkDxy6k8S54Mklj703q5lf4nAOyN/DnevQUcHfi2PlfO9DzJwGDvGxWV1boLa2PrONFZ9XMNaW
 sKhq1cR9U1R+wfYZs4csdihPPD2R4EMLHW1nbg70HEpgMoLATz0pJRf48ZJf4kTPhNlftSEy9gS
 vT26n8klEEs+eC6xP8DgLS/YTqFEKXdGuv8SpiiTApGoWJ2x4XKH9DLT17HgWAhZVVEj+KcD4GR
 iB6RNyu9vKPBk7R5Z44jmPm2f0Sk/uYH0fiomVgqATyklNpTUe6g==
X-Received: by 2002:a17:907:2d9e:b0:b87:908:9aca with SMTP id
 a640c23a62f3a-b87968a9870mr348704066b.9.1768598219827; 
 Fri, 16 Jan 2026 13:16:59 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795168ca9sm336649066b.15.2026.01.16.13.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 13:16:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH 01/11] doc: correct errors in Linux system requirements guide
Date: Fri, 16 Jan 2026 13:06:17 -0800
Message-ID: <20260116211649.104776-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116211649.104776-1-stephen@networkplumber.org>
References: <20260116211649.104776-1-stephen@networkplumber.org>
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

Changes:
- Fix capitalization of IBM Advance Toolchain
- Remove double spaces before "support"
- Add missing preposition "in" and article "the"
- Fix hugetlbfs mount command syntax (add -o flag and device)

Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/linux_gsg/sys_reqs.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/doc/guides/linux_gsg/sys_reqs.rst b/doc/guides/linux_gsg/sys_reqs.rst
index 52a840fbe9..869584c344 100644
--- a/doc/guides/linux_gsg/sys_reqs.rst
+++ b/doc/guides/linux_gsg/sys_reqs.rst
@@ -68,7 +68,7 @@ Compilation of the DPDK
 
 *   Intel\ |reg| oneAPI DPC++/C++ Compiler.
 
-*   IBM\ |reg| Advance ToolChain for Powerlinux. This is a set of open source development tools and runtime libraries
+*   IBM\ |reg| Advance Toolchain for Powerlinux. This is a set of open source development tools and runtime libraries
     which allows users to take leading edge advantage of IBM's latest POWER hardware features on Linux. To install
     it, see the IBM official installation document.
 
@@ -93,7 +93,7 @@ e.g. :doc:`../nics/index`
 Running DPDK Applications
 -------------------------
 
-To run a DPDK application, some customization may be required on the target machine.
+To run a DPDK application, customization may be required on the target machine.
 
 System Software
 ~~~~~~~~~~~~~~~
@@ -127,9 +127,9 @@ System Software
 
     *   HUGETLBFS
 
-    *   PROC_PAGE_MONITOR  support
+    *   PROC_PAGE_MONITOR support
 
-    *   HPET and HPET_MMAP configuration options should also be enabled if HPET  support is required.
+    *   HPET and HPET_MMAP configuration options should also be enabled if HPET support is required.
         See the section on :ref:`High Precision Event Timer (HPET) Functionality <High_Precision_Event_Timer>` for more details.
 
 .. _linux_gsg_hugepages:
@@ -138,7 +138,7 @@ Use of Hugepages in the Linux Environment
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Hugepage support is required for the large memory pool allocation used for packet buffers
-(the HUGETLBFS option must be enabled in the running kernel as indicated the previous section).
+(the HUGETLBFS option must be enabled in the running kernel as indicated in the previous section).
 By using hugepage allocations, performance is increased since fewer pages are needed,
 and therefore less Translation Lookaside Buffers (TLBs, high speed translation caches),
 which reduce the time it takes to translate a virtual page address to a physical page address.
@@ -225,10 +225,10 @@ However, in order to use hugepage sizes other than the default, it is necessary
 to manually create mount points for those hugepage sizes (e.g. 1GB pages).
 
 To make the hugepages of size 1GB available for DPDK use,
-following steps must be performed::
+the following steps must be performed::
 
     mkdir /mnt/huge
-    mount -t hugetlbfs pagesize=1GB /mnt/huge
+    mount -t hugetlbfs -o pagesize=1GB none /mnt/huge
 
 The mount point can be made permanent across reboots, by adding the following line to the ``/etc/fstab`` file::
 
-- 
2.51.0

