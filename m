Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B8D606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 00:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qtwnjV/T
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 729F440272;
	Mon,  9 Nov 2026 01:49:31 +0100 (CET)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by mails.dpdk.org (Postfix) with ESMTPS id 2C5804021E
 for <dev@dpdk.org>; Mon,  9 Nov 2026 01:49:30 +0100 (CET)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-490a0e72588so166394f8f.3
 for <dev@dpdk.org>; Sun, 08 Nov 2026 16:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794185370; x=1794790170; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MXEjZFc2K35mHrR9H7kvPnpAZNCzuOUtv064JfgJXsg=;
 b=qtwnjV/TbKhZ1tzYFPQ1yD5H75zb9Y+5sTm4vRLeTdhbbQKRlpBYmnLcFY/KvTLzaY
 bH1pgFiSMMl8JOZvRMIrEMSMgSXLq0DmStBx5rYEYA0D3OPFwOplcYUpDzLp2cp+N4aD
 YIuaHuOPo4KjYS9jTtQrQhQPMDw6/SGY7awGtBTxpQ07M40MPfoCiJjf2K2p0CQ0sf5r
 76uqJqBt85TVh2G1hN47M0+y6bUOxI9SbhTAAM8W1lzkyBqdI8grf1hgsAL3z2mfMEE/
 sQHV+ZjkbpH6CMnuPzPLzAqGQtD3BzWHkj47+X/SmrJfJKmIoL/mUjs5+Zee+JzmhJ/n
 FRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794185370; x=1794790170;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MXEjZFc2K35mHrR9H7kvPnpAZNCzuOUtv064JfgJXsg=;
 b=yMC1MPJg8IKdtQEsnuToPPDS2iP4EFZbVFawuoVwlxRoUaLRVy+EMrob9E+z8C9Ex/
 YzlOqondMvfFw/fSC12cT1pgDkxx07kW2ewPpYVDr7ogNPWpe9keny4gN4JZ+9+wkiaR
 tW5E5fdcWBGVkbe0nYe7DIkU3qJH9wr2YBKsTShUtISqHE81QQLjkuZoNe0tlqMVa68I
 JpjKZP+CMB1wWpSvjoSZ7PTH/8YktGCISz3JzUf3eLer9lnqJoXroPuuadl1vCXgf39l
 4qGth2wAWAyg14iQq7SM0mAmOGBmWcWTysbe/d+A7AjmoRvA+R2wvKgnEaFxBPQec8MT
 8DVg==
X-Gm-Message-State: APuU4Z+CVcMDROEUuDq2LmiTVIyffvCHufcKCA63KjWEURGMgj3M1YrO
 qZ5daiSl5RVM8qqUeYPzLJBcov0KqKiCoTBIvgheA54MULNpdhCY8Iz6SgS34Q==
X-Gm-Gg: AYBFou2mOgzkxQxXW7JR9ltTViYrASefWjFBJGMctAqHy9rSDS00xPDEjwh8Bh6tN+Q
 vTfyFHFAKkD/Mgo6uUtj1YA6ERuG1CCWJYDi6eOfVhZtBC6dJoe91l5N7JaP5Gyd4uvh/pBQ6aR
 6RmC2azYHqAamJwUa1opaGLC7C3mm+UynAr5UgQwcnMLoBGzRAwP5AmVtxn6Ot4aifyQAEWlX3f
 YI/leJqY9RVOE+r9oILYx9ekLmQ+KYTHyDiSZkXIKcqGuvgUe7WrOMALFucUUQasmu4oELHnQu9
 /adUUnQOT40Hvt1TqcMn+EaRO7IDLroBNa0vzQcQdMnLG/ktDSsv8/Gob4zCwMrDFenFocSAjGv
 AEExF64u9TsP0AYSe/TwN8c3BOKJ5XH0UlUehficuNnphVEKM1kAY8vTAsk4UWbCF7P6/n+HMMI
 ZMH/f4kDaXtz7uNMRklkpAYqdqdNNFIVLGzAD8JVsbxegp94C3piSwVxYjVPASMUBvG8KKBPCAR
 OxITTiv+hlbVJlniJw6Gg/cjSyE6JBFWNI162ks9xUvcN/AgwzzhrY7CWF4vVRHi3sR0/XPccrE
 7B1C9KrMeJUEkIHt9Wug7CHRa4aj1XHBioh3aAu+o5h11l4fSjYdp8ue1HrLJAMCi3acUo5nhB4
 IBx2fD9k2Di2ukjPcDw1AlaCvZ2EzbQA=
X-Received: by 2002:a05:6000:2c0a:b0:48e:68da:1c5c with SMTP id
 ffacd0b85a97d-49583ee23c3mr5844096f8f.16.1794185369441; 
 Sun, 08 Nov 2026 16:49:29 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:2f07:7010:6500:f3ca:cc4f:cbe2:3b75])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597748acbsm6663046f8f.44.2026.11.08.16.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 16:49:28 -0800 (PST)
From: Andrei-Niculae Petre <p31andrei@gmail.com>
To: dev@dpdk.org
Cc: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrei-Niculae Petre <p31andrei@gmail.com>
Subject: [PATCH] examples/l3fwd: sync cli options with documentation
Date: Mon,  9 Nov 2026 02:49:13 +0200
Message-Id: <20261109004913.72418-1-p31andrei@gmail.com>
X-Mailer: git-send-email 2.39.5
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Synchronize options between print_usage() in main.c and the sample app
guide documentation (l3_forward.rst).

Specifically:
- Add missing options to print_usage() synopsis: --eth-link-speed,
  --disable-rss, --relax-rx-offload, --event-eth-rxqs, and --alg.
- Add missing option descriptions in print_usage(): --disable-rss and
  --relax-rx-offload.
- Add missing options to l3_forward.rst: --eth-link-speed,
  --rx-queue-size, --tx-queue-size, --mbcache, --disable-rss,
  --relax-rx-offload, and --alg.
- Remove obsolete --hash-entry-num from l3_forward.rst as the option
  has been ignored since commit f5251734c5e1 ("examples/l3fwd: remove
  hash entry number").

All 25 active long options are now fully documented and aligned across
main.c and l3_forward.rst.

Doing a pass of all the options shows main.c >= 2 and rst >= 2 for each
of them, proving no more omissions exist now.

$ for opt in $(grep -oP '#define CMD_(LINE|LINK)_OPT_\w+\s+"\K[^"]+' \
  examples/l3fwd/main.c | grep -v 'hash-entry-num'); do
    printf "%-20s: main.c: %2d, rst: %2d\n" "$opt" \
        "$(grep -c -- "--$opt" examples/l3fwd/main.c)" \
        "$(grep -c -- "--$opt" doc/guides/sample_app_ug/l3_forward.rst)"
done
config              : main.c:  2, rst:  5
eth-link-speed      : main.c:  2, rst:  2
rx-queue-size       : main.c:  2, rst:  2
tx-queue-size       : main.c:  2, rst:  2
eth-dest            : main.c:  2, rst:  2
no-numa             : main.c:  2, rst:  2
ipv6                : main.c:  2, rst:  3
max-pkt-len         : main.c:  2, rst:  2
parse-ptype         : main.c:  2, rst:  2
disable-rss         : main.c:  2, rst:  2
relax-rx-offload    : main.c:  2, rst:  2
per-port-pool       : main.c:  2, rst:  2
mode                : main.c:  4, rst:  8
eventq-sched        : main.c:  2, rst:  6
event-eth-rxqs      : main.c:  2, rst:  2
lookup              : main.c:  4, rst:  4
event-vector        : main.c:  4, rst:  4
event-vector-size   : main.c:  2, rst:  2
event-vector-tmo    : main.c:  2, rst:  2
rule_ipv4           : main.c:  2, rst:  6
rule_ipv6           : main.c:  2, rst:  6
alg                 : main.c:  2, rst:  2
rx-burst            : main.c:  2, rst:  2
tx-burst            : main.c:  2, rst:  2
mbcache             : main.c:  2, rst:  2

Bugzilla ID: 545

Signed-off-by: Andrei-Niculae Petre <p31andrei@gmail.com>
---
 .mailmap                                |  1 +
 doc/guides/sample_app_ug/l3_forward.rst | 28 +++++++++++++++++++------
 examples/l3fwd/main.c                   |  7 +++++++
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/.mailmap b/.mailmap
index 754dd9e760..844deef539 100644
--- a/.mailmap
+++ b/.mailmap
@@ -115,6 +115,7 @@ Andre Richter <andre.o.richter@gmail.com>
 Andrea Arcangeli <aarcange@redhat.com>
 Andrea Grandi <andrea.grandi@intel.com>
 Andrea Panattoni <apanatto@redhat.com>
+Andrei-Niculae Petre <p31andrei@gmail.com> <andrei.petre@keysight.com>
 Andrew Bailey <abailey@iol.unh.edu>
 Andrew Boyer <andrew.boyer@amd.com> <aboyer@pensando.io>
 Andrew Harvey <agh@cisco.com>
diff --git a/doc/guides/sample_app_ug/l3_forward.rst b/doc/guides/sample_app_ug/l3_forward.rst
index 452bd8cc6c..996e01439c 100644
--- a/doc/guides/sample_app_ug/l3_forward.rst
+++ b/doc/guides/sample_app_ug/l3_forward.rst
@@ -77,19 +77,25 @@ The application has a number of command line options::
                              [-P]
                              [--lookup LOOKUP_METHOD]
                              --config(port,queue,lcore)[,(port,queue,lcore)]
+                             [--eth-link-speed SPEED]
+                             [--rx-queue-size NPKTS]
+                             [--tx-queue-size NPKTS]
                              [--rx-burst NPKTS]
                              [--tx-burst NPKTS]
+                             [--mbcache CACHESZ]
                              [--eth-dest=X,MM:MM:MM:MM:MM:MM]
                              [--max-pkt-len PKTLEN]
                              [--no-numa]
-                             [--hash-entry-num]
                              [--ipv6]
                              [--parse-ptype]
+                             [--disable-rss]
+                             [--relax-rx-offload]
                              [--per-port-pool]
                              [--mode]
                              [--eventq-sched]
                              [--event-eth-rxqs]
                              [--event-vector [--event-vector-size SIZE] [--event-vector-tmo NS]]
+                             [--alg ALG]
                              [-E]
                              [-L]
 
@@ -115,22 +121,35 @@ Where,
 
 * ``--config (port,queue,lcore)[,(port,queue,lcore)]:`` Determines which queues from which ports are mapped to which cores.
 
+* ``--eth-link-speed SPEED:`` Optional, forces link speed (e.g. 10, 100, 1000, 10000 Mbps).
+
+* ``--rx-queue-size NPKTS:`` Optional, sets the number of Rx descriptors per queue (default 1024).
+
+* ``--tx-queue-size NPKTS:`` Optional, sets the number of Tx descriptors per queue (default 1024).
+
 * ``--rx-burst NPKTS:`` Optional, Rx burst size in decimal (default 32).
 
 * ``--tx-burst NPKTS:`` Optional, Tx burst size in decimal (default 32).
 
+* ``--mbcache CACHESZ:`` Optional, sets the mbuf pool cache size per lcore (default 512).
+
 * ``--eth-dest=X,MM:MM:MM:MM:MM:MM:`` Optional, ethernet destination for port X.
 
 * ``--max-pkt-len:`` Optional, maximum packet length in decimal (64-9600).
 
 * ``--no-numa:`` Optional, disables numa awareness.
 
-* ``--hash-entry-num:`` Optional, specifies the hash entry number in hexadecimal to be setup.
-
 * ``--ipv6:`` Optional, set if running ipv6 packets.
 
 * ``--parse-ptype:`` Optional, set to use software to analyze packet type. Without this option, hardware will check the packet type.
 
+* ``--disable-rss:`` Optional, disables RSS (Receive Side Scaling).
+
+* ``--relax-rx-offload:`` Optional, relaxes Rx offload requirements based on device
+  capabilities. When requested offloads (such as IPv4 checksum offload) are not supported
+  by the device (e.g., virtual devices such as ``vhost``, ``virtio``, or ``pcap``),
+  unsupported offloads are masked off and software validation is enabled.
+
 * ``--per-port-pool:`` Optional, set to use independent buffer pools per port. Without this option, single buffer pool is used for all ports.
 
 * ``--mode:`` Optional, Packet transfer mode for I/O, poll or eventdev.
@@ -321,9 +340,6 @@ for the convenience to execute hash performance test on 4M/8M/16M flows.
 .. note::
 
     Value of global variable ipv6 can be specified with --ipv6 in the command line.
-    Value of global variable hash_entry_number,
-    which is used to specify the total hash entry number for all used ports in hash performance test,
-    can be specified with --hash-entry-num VALUE in command line, being its default value 4.
 
 .. code-block:: c
 
diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
index 9532150a47..aad33eb5d4 100644
--- a/examples/l3fwd/main.c
+++ b/examples/l3fwd/main.c
@@ -397,6 +397,7 @@ print_usage(const char *prgname)
 		" [-P]"
 		" [--lookup]"
 		" --config (port,queue,lcore)[,(port,queue,lcore)]"
+		" [--eth-link-speed SPEED]"
 		" [--rx-queue-size NPKTS]"
 		" [--tx-queue-size NPKTS]"
 		" [--rx-burst NPKTS]"
@@ -407,12 +408,16 @@ print_usage(const char *prgname)
 		" [--no-numa]"
 		" [--ipv6]"
 		" [--parse-ptype]"
+		" [--disable-rss]"
+		" [--relax-rx-offload]"
 		" [--per-port-pool]"
 		" [--mode]"
 #ifdef RTE_LIB_EVENTDEV
 		" [--eventq-sched]"
+		" [--event-eth-rxqs]"
 		" [--event-vector [--event-vector-size SIZE] [--event-vector-tmo NS]]"
 #endif
+		" [--alg ALG]"
 		" [-E]"
 		" [-L]\n\n"
 
@@ -439,6 +444,8 @@ print_usage(const char *prgname)
 		"  --no-numa: Disable numa awareness\n"
 		"  --ipv6: Set if running ipv6 packets\n"
 		"  --parse-ptype: Set to use software to analyze packet type\n"
+		"  --disable-rss: Disable RSS\n"
+		"  --relax-rx-offload: Relax Rx offload mode\n"
 		"  --per-port-pool: Use separate buffer pool per port\n"
 		"  --mode: Packet transfer mode for I/O, poll or eventdev\n"
 		"          Default mode = poll\n"
-- 
2.39.5

