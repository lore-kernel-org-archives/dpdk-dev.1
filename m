Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B5C606A884
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Nov 2026 21:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E+PTb1e1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B108D4025A;
	Sun, 15 Nov 2026 22:57:18 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by mails.dpdk.org (Postfix) with ESMTPS id A9365400EF
 for <dev@dpdk.org>; Sun, 15 Nov 2026 22:57:17 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so1386223f8f.2
 for <dev@dpdk.org>; Sun, 15 Nov 2026 13:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794779837; x=1795384637; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=msTXYs8QGR0ztzvNUfvbLCAo9uZ+7h4QysCRC5wb5Fk=;
 b=E+PTb1e1x9N5uehhdRTFlGjmH4DvquHtJ88n4ojjYDmsSBqpf2DLSaCXH36d68iM8O
 JLACWUsXEnu1dlFCRko+zZsG5xgHiJeAAuIGNcJv5ogCuCJSW/z/VJTztZiMztP+Fl8b
 K9E4WI4iv6MsJFFT+5DF+vtwkeZ8MapVrQqa4zjDlhy3/LWhh+S7EHpEZjGds+mjr/aF
 nxaMLQT48lPE7wrjabDEUdAIvSixtzrq209D9EPkez/jYti2H8hVQH6I0NKSV++F3XC3
 CSQoU2ibCkr7oWgBfd8rGQd19JBqtV5zbIUeMW+uZKtDZH7lYK2dqJgWEI0p4SkdAFV2
 P8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794779837; x=1795384637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=msTXYs8QGR0ztzvNUfvbLCAo9uZ+7h4QysCRC5wb5Fk=;
 b=KNQoXg2phrw7zBmJHrIULZWRr3BWGFNjs5USwkYstbdzCke36hV+ZxAYhZYdBguc1F
 gpDgxnt0mFQpsfTku7m+2exVMgANm38YyZ/fUV+WReajvn/MY42GXVC3ZeaxcuKYrQ7o
 OUVWQT66nN9Q3+Xluoqnl+YiM+INaER1N/QF9FAfvft5jaSHdqgROTXwisOFXJq34w25
 8izI15XMqGtfJ1CAOJqs41KHz4KsHsd1eRjb5Da6fJwlzSottBy+wYnTlzALS1emoHy/
 gKbqgGhl+J5HipnUmDyYvhXeLfXIZMZbYa+yIHZpww0WIIvQcR4dfgInTRCHNrVaeXLV
 3MPA==
X-Gm-Message-State: APuU4Z9JL0AcGcEMoacS00G5tPpWFwlkdUQ3vJZphV1Rzr9xGJmw/VNQ
 SYnNCUqyhp24XlMoYyrNkQ/13Qq6iOJF6T2jm4HvGgm3rq/1eIZNSP53Qj4Qow==
X-Gm-Gg: AYBFou3GUJNVexn3FpaKm8fL19sGe69wwSk0Dz3coZFmAJ0QCfwR7Ie0X1kCFHVtxbM
 QBXYo2J8S0271XRWYk/46klFe7WXo7JdBx1WghNrTPHTgmpKI1Z22aM/ulP/f2KDnNj57egP9Ql
 YkhFwAbD6sK8spMjEwHFiV7DnqCLoVT6gcrQHWhMl3Iw79JFItMfcuyhhzPq+F+QtKgtl+pgGTT
 HQOxBjTXAttI2OEIB7BEo4ndEcw8vGsjXjKgOcyJmaibU0pZG10iJ2ZLwEng/MSH0sibDv7lStJ
 oVJ8AD89HVEMQg/pIbo4MkeAbWU65sAdoWgwrnjYPlxYlPO2B8Nk2C6t9AJVV6dAPRxz0YeH9gV
 bhjZ8/CRi2MDjfFnbZ6oFB3CHR+eDXMXjiIVUjRnteT37RGJpRtwGGUzFwXc2tSHOYWqV5TRPTO
 MOwJ25Xb3U+1d9Whx6Bb9pQ/OGHbHTsBzJs9scF9J5qiw9pRuoGt6s6MaNsQluMi2XcftpoHJV1
 D21Q91O+VLDJA6m6gVmsRQOH4hz1BAizbZYI6TRCypyusTeZhxRzumau3rl/qflzsIWa6cqlnrf
 pMQiCAG421eYzhsam++F2SbiAEi+tTaHEivBoKaHzzC9f082wc9Y+wBFlGCN4XrTbGT2LUuL1/s
 PtYGlsBgw4WIu//xp/y9Uy/S0XNGmP2I=
X-Received: by 2002:a05:6000:1ac5:b0:490:71a7:6f3c with SMTP id
 ffacd0b85a97d-49c7325b963mr21520889f8f.55.1794779836897; 
 Sun, 15 Nov 2026 13:57:16 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:2f07:7010:6500:f3ca:cc4f:cbe2:3b75])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c607d12c4sm17255590f8f.41.2026.11.15.13.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 13:57:16 -0800 (PST)
From: Andrei-Niculae Petre <p31andrei@gmail.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	Andrei-Niculae Petre <p31andrei@gmail.com>
Subject: [PATCH v2] examples/l3fwd: sync cli options with documentation
Date: Sun, 15 Nov 2026 23:56:57 +0200
Message-Id: <20261115215657.14694-1-p31andrei@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261109004913.72418-1-p31andrei@gmail.com>
References: <20261109004913.72418-1-p31andrei@gmail.com>
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
- Clarify in print_usage() that --eth-link-speed unit is in Mbps.
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
v2:
* Remove 10 and 100 Mbps from --eth-link-speed documentation examples as
  they are explicitly rejected by the parser.
* Clarify that --relax-rx-offload masks unsupported offloads to allow
  configuration, but does not enable software validation across all
  forwarding paths.
* Clarify in print_usage() that --eth-link-speed unit is in Mbps.
---
---
 doc/guides/sample_app_ug/l3_forward.rst | 30 ++++++++++++++++++++-----
 examples/l3fwd/main.c                   |  9 +++++++-
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/doc/guides/sample_app_ug/l3_forward.rst b/doc/guides/sample_app_ug/l3_forward.rst
index 4e87141608..73f4f4ce41 100644
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
 
@@ -115,22 +121,37 @@ Where,
 
 * ``--config (port,queue,lcore)[,(port,queue,lcore)]:`` Determines which queues from which ports are mapped to which cores.
 
+* ``--eth-link-speed SPEED:`` Optional, forces link speed (e.g. 1000, 10000, 25000, 40000, 100000 Mbps).
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
+  capabilities. When requested offloads (such as Rx checksum offload) are not supported
+  by the device (e.g., virtual devices such as ``vhost``, ``virtio``, or ``pcap``),
+  unsupported offloads are masked off so the device can be configured
+  successfully, but note that software validation is not enabled on all
+  forwarding paths.
+
 * ``--per-port-pool:`` Optional, set to use independent buffer pools per port. Without this option, single buffer pool is used for all ports.
 
 * ``--mode:`` Optional, Packet transfer mode for I/O, poll or eventdev.
@@ -322,9 +343,6 @@ for the convenience to execute hash performance test on 4M/8M/16M flows.
 .. note::
 
     Value of global variable ipv6 can be specified with --ipv6 in the command line.
-    Value of global variable hash_entry_number,
-    which is used to specify the total hash entry number for all used ports in hash performance test,
-    can be specified with --hash-entry-num VALUE in command line, being its default value 4.
 
 .. code-block:: c
 
diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
index 060a68b7aa..5d061a1cf7 100644
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
 
@@ -423,7 +428,7 @@ print_usage(const char *prgname)
 		"            Accepted: em (Exact Match), lpm (Longest Prefix Match), fib (Forwarding Information Base),\n"
 		"                      acl (Access Control List)\n"
 		"  --config (port,queue,lcore): Rx queue configuration\n"
-		"  --eth-link-speed: force link speed\n"
+		"  --eth-link-speed: force link speed (Mbps)\n"
 		"  --rx-queue-size NPKTS: Rx queue size in decimal\n"
 		"            Default: %d\n"
 		"  --tx-queue-size NPKTS: Tx queue size in decimal\n"
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

