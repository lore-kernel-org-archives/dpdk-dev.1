Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67148CC6B0E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 08:28:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FF0140272;
	Tue, 13 Oct 2026 10:28:45 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id 53BC1400D6
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:28:44 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=wluQDPYfmibOHcz8sBPpLdBZEl82rPY5GANzZKz65FQ=;
 b=Yb4ymZGzDaEkvwIgfG8cQxtCdhzrAmBZ0Us3hRfLQGSA5z5h2FSC7U8PdHPeecSJCTOouob1r
 vmIGDJX9XXRLwgu21+PlewcrhLZ8aeIzxogMORqMeEbussRx1x3Tg5lutCNE2wCi0k+gZa66wmg
 lTNb/tJNQ6o6FZ56mYZYDgA=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4j3nGv0F7yz1prLV;
 Tue, 13 Oct 2026 16:16:23 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 19B4C40537;
 Tue, 13 Oct 2026 16:28:42 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 13 Oct 2026 16:28:41 +0800
Message-ID: <96108bc1-6004-4c94-a39f-133650e5f468@huawei.com>
Date: Tue, 13 Oct 2026 16:28:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] wireshark capture implementation
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
References: <20260727224417.1419663-1-stephen@networkplumber.org>
 <20261013034145.979361-1-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20261013034145.979361-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500009.china.huawei.com (7.202.194.199)
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

Hi Stephen,

A live Wireshark capture capability via extcap and telemetry is a highly anticipated
feature for runtime debugging. In our previous high-throughput testing with file-based
captures, we frequently encountered severe bottlenecks where packets could not be written
to disk fast enough, leading to massive ring buffer overflows and packet drops.
Therefore, the implementation details of this feature are of great interest to us.

Reviewing the current v4 architecture, I have two major concerns:

1) Security Aspect & Telemetry Attack Surface
The introduction of control operations (such as dynamically registering rx/tx
callbacks and passing arbitrary FIFO paths) drastically expands the attack
surface of the otherwise read-only telemetry interface. Could we introduce
a dedicated "debug mode" configuration to strictly guard these write paths?
Furthermore, it would be beneficial to know if this mode plans to support
more control interfaces down the road, such as a "stats_reset" command.

2) Performance Impact & Thread Isolation
The current implementation enforces a deep copy for captured packets. Have
you considered an adaptive approach? For instance, allowing a lightweight
shallow copy (mbuf clone) under certain conditions to save CPU cycles, while
reverting to a deep copy only when conflicting offloads (like FAST_FREE)
are active on the TX path.

Additionally, how is the actual packet writing thread managed and controlled?
To prevent I/O blocking from introducing jitter into the fast path, should
we consider isolating this writing worker thread onto a dedicated, isolated
core (ecore/lcore)?

Thanks

On 10/13/2026 11:41 AM, Stephen Hemminger wrote:
> This series adds live packet capture from a running DPDK application over the
> telemetry socket. A new capture library installs Rx/Tx callbacks on an ethdev
> port and writes pcapng to a FIFO, with an optional libpcap filter and
> per-queue selection. A helper program presents those ports to Wireshark as
> capture interfaces.
> 
> Advantages of this:
>  - no secondary process needed to capture
>  - installation is just putting the helper in the Wireshark extcap directory
>  - the helper has no dependency on DPDK libraries; can be packaged with
>    Wireshark
>  - allows for live capture
>  - supports BPF (with JIT) for filtering
> 
> How it works:
>  - The capture library registers telemetry commands (/ethdev/capture/*)
>  - Callbacks are installed on the specified port/queues to copy packets
>  - Packets are formatted as pcapng and written to the specified output
>  - No packet data passes through the telemetry socket itself
> 
> Packets handled by a secondary process are captured too, using EAL IPC as
> pdump does.
> 
> The helper is a C program so that it can be installed with privilege, which
> is what lets Wireshark capture from a root application without itself running
> as root. See doc/guides/tools/wireshark_extcap.rst.
> 
> Linux and FreeBSD only. Windows needs the transport first: telemetry has no
> socket server there and uses SOCK_SEQPACKET, which Windows AF_UNIX lacks.
> A stream socket would need the replies framed.
> 
> Testing:
>   - dpdk-wireshark-extcap --extcap-interfaces lists the ports. Reasons for an
>     empty list go to stderr, which the Wireshark GUI hides.
>   - Unit tests are in app/test/test_capture.c
>   - Tested on Linux capturing from a root application as a non-root user.
>     The unit test also passes on FreeBSD.
> 
> v4
>  - helper rewritten in C, and can be installed with privilege so Wireshark
>    need not run as the same user as the DPDK application
>  - capture packets handled by secondary processes
>  - split the library into several files by area
>  - dropped the pcapng change adding the filter-accepted count to the
>    interface statistics block. Still reported through telemetry.
> 
> v3 - fixed AI review feedback
> 
> Stephen Hemminger (3):
>   capture: infrastructure wireshark packet capture
>   test: add test for capture hooks
>   usertools: add script for wireshark capture
> 
>  MAINTAINERS                            |    4 +
>  app/test/meson.build                   |    1 +
>  app/test/test_capture.c                |  688 ++++++++++++++
>  doc/guides/prog_guide/capture_lib.rst  |  167 ++++
>  doc/guides/prog_guide/index.rst        |    1 +
>  doc/guides/rel_notes/release_26_11.rst |    5 +
>  doc/guides/tools/index.rst             |    1 +
>  doc/guides/tools/wireshark_extcap.rst  |  198 ++++
>  lib/capture/capture.c                  |  560 ++++++++++++
>  lib/capture/datapath.c                 |  420 +++++++++
>  lib/capture/filter.c                   |  180 ++++
>  lib/capture/meson.build                |   24 +
>  lib/capture/multiproc.c                |  246 +++++
>  lib/capture/output.c                   |  294 ++++++
>  lib/capture/private.h                  |  214 +++++
>  lib/meson.build                        |    1 +
>  usertools/dpdk-wireshark-extcap.c      | 1145 ++++++++++++++++++++++++
>  usertools/meson.build                  |   23 +
>  18 files changed, 4172 insertions(+)
>  create mode 100644 app/test/test_capture.c
>  create mode 100644 doc/guides/prog_guide/capture_lib.rst
>  create mode 100644 doc/guides/tools/wireshark_extcap.rst
>  create mode 100644 lib/capture/capture.c
>  create mode 100644 lib/capture/datapath.c
>  create mode 100644 lib/capture/filter.c
>  create mode 100644 lib/capture/meson.build
>  create mode 100644 lib/capture/multiproc.c
>  create mode 100644 lib/capture/output.c
>  create mode 100644 lib/capture/private.h
>  create mode 100644 usertools/dpdk-wireshark-extcap.c
> 

