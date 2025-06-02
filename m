Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D52C5B555
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 20:35:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 468F7402C9;
	Mon,  2 Jun 2025 22:35:33 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id D73C94028E
 for <dev@dpdk.org>; Mon,  2 Jun 2025 22:35:31 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3121aed2435so4384897a91.2
 for <dev@dpdk.org>; Mon, 02 Jun 2025 13:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748896530; x=1749501330; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pPDkAsDs1MIlHetXTQ9du6uQgOcjRT80hEFObZBGGw8=;
 b=PP8TP1PJ7EieiaYvvlxI0JHspM3oPKCyTmYlIxyn9byihFu37eQtMcQjmqkKHjFbVj
 KkpX7QOq6CYe3vjQzPioWD7zPqwZ4k7roR3/VbNI9mEM+RDVwkDxowozDPEnGQ/qwXSZ
 ThbcXElPVGBrMmjpJdoXeHMknzMpqrT0xhjUWJR8d1OMeRX+qAdha26nmY0kQ5DMujl6
 1zEOTnsT+pTGz6GWLvtgdj8cvXRTg6fNEqBNcq9vmvwsMNIKzAVBsBdcZWVSPem36lEH
 0fP+4uziCCHsJdEh2UcwExyDq5AokfvjP6cD21NALf3B37IhDfoxHjUt23LFFAfirqHC
 sL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748896530; x=1749501330;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pPDkAsDs1MIlHetXTQ9du6uQgOcjRT80hEFObZBGGw8=;
 b=SLIHTb/hOr/RhP4ludRbY58+W+K8UDXuI47rLCeGqNjU14U8YtwkJshWukNqtbFTtx
 n1cb38zL/ailyOnyG2bf9vds9yrHIjQGgWms/5v30lz/feYhp1knTcGX00WfuGAvnrtl
 EuGoHTNPx4ebQQF8vdKtQ7adYCZXIS0jcKW+16hlj1SVq/Gdbox7urA+trjCKn4+CYA3
 GIsdv5DU0O6eATqTloNKo4MElomNluqDpQSA2rvCmiC1zWaCRlAMLAln2/xPCct8B9wc
 tBGVH/63ArqfyRAsgRP+EZmyGhQfZD37PP53rXrsjrID8tsSsFnI2JaQ7uHrpNrhcvoW
 oq8w==
X-Gm-Message-State: AOJu0Yxd7lnt4nA5sHRyAXnY94TstLOdKteFnP7RKuPuKvBaSyX0MGc1
 hqpAnWSc4fgImNqQc3j8gB98FhL25gQxDxsyxsjdBih2W3MyRtbZgs/AxJlFznQFoHA7g6RoUcY
 ehwJWpjxZKqlaaXX+TXspT6ngfGuw3BcG6eda
X-Gm-Gg: ASbGncsd2NWQ+N/859LK9MK6gORkGnni6A2UZ1WADXt5tI6JlueM+5QvYWcyV4IpX2F
 gXQjxtvtPoqHSLnmxJj+3zuFfp7XCpPI5w0awkjL8yjWEe51iaNJptWl/+CfdFyuWfW9fTZETRr
 oWk4Ev+bUGlHyDb6LlEtxsfFbZmVL5w76KTIrr2fD3BMW+sscz8MnBq9c=
X-Google-Smtp-Source: AGHT+IFbNNXjWigwz/8NKGQ9TI+hgFGEC6hSx4d3yQQDz0QWPYw3habQrIO62tqdZ/uoEHoFDZSj7jqsV/T7HObscHw=
X-Received: by 2002:a17:90b:4c09:b0:312:1b53:5ead with SMTP id
 98e67ed59e1d1-31240d1c0d7mr20417319a91.4.1748896530376; Mon, 02 Jun 2025
 13:35:30 -0700 (PDT)
MIME-Version: 1.0
From: Ashish Sadanandan <ashish.sadanandan@gmail.com>
Date: Mon, 2 Jun 2025 14:35:04 -0600
X-Gm-Features: AX0GCFviLbzhWCg23cWcVAkSjCkexKMS6lKTX_4aGyzo4r9lbTyUSt6Wdor3920
Message-ID: <CAN44U22Jq=Gap8YjKUeEUm4D8p5Th_M38YkCheKk67EpKmR-zw@mail.gmail.com>
Subject: ethdev use from secondary process
To: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000712e7d06369cb4eb"
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

--000000000000712e7d06369cb4eb
Content-Type: text/plain; charset="UTF-8"

Hi everyone,
I'm trying to use a secondary process to rx/tx packets through a NIC and
running into segfaults due to some data structures not being populated on
the secondary. I've figured out a solution, but it involves the use of
internal APIs and I wanted to check with the community if there's a better
way to do this.

I'm using DPDK 24.11 LTS for this test. The test code is at
https://gist.github.com/praetorian20/0c1b69abbc7843d958da72fdf611a5d7. I'll
describe the steps I'm following here.

Primary process:

   1. Command line: sudo LD_LIBRARY_PATH=/path/to/dpdk/shared/libs/
   ./test-ethdev --main-lcore 0 --file-prefix=mpdemo --socket-mem=1024 -d
   /path/to/dpdk/shared/libs/dpdk/pmds-25.0 --proc-type primary
   2. Calls rte_eal_init
   3. Registers message handler using  rte_mp_action_register
   4. Waits indefinitely for CTRL+C

Secondary process:

   1. Command line: Same as primary, except --proc-type=secondary
   2. Calls rte_eal_init
   3. Registers message handler using  rte_mp_action_register
   4. Creates a mempool using rte_pktmbuf_pool_create
   5. Sends request message to primary using  rte_mp_request_async

Primary process (upon receiving the async request):

   1. Look up the mempool created by the secondary
   2. Get port id for a particular ethdev using PCI address
   3. Call rte_eth_dev_configure,  rte_eth_rx_queue_setup,
rte_eth_tx_queue_setup
   and  rte_eth_dev_start to start the ethdev
   4. Send response to secondary

Secondary process (upon receiving response):

   1. Call  rte_eth_dev_get_port_by_name to fetch port id
   2. Call  rte_eth_dev_attach_secondary and  rte_eth_dev_probing_finish to
   initialize data structures. Without this the next step has segv
   because rte_eth_fp_ops.rxq.data is nullptr
   3. Call rte_eth_rx_burst to receive packets


The above works but I have a few questions whether this process can be
improved. I'm using an Nvidia ConnectX6 NIC (mlx5 driver) in case that
matters.


   - Are there public APIs I can call instead of
   rte_eth_dev_attach_secondary and  rte_eth_dev_probing_finish?
   - Is it possible to perform rte_eth_dev_configure, tx/rx queue setup and
   rte_eth_dev_start from the secondary process? These functions return
   various error codes when I try this.
   - When I call rte_eth_dev_start on the primary, it's sending a message
   to the secondary that goes unhandled. Is this a problem, and possibly the
   reason for the unpopulated rte_eth_fp_ops on the secondary? This is the
   error message I see from the primary:

EAL: Fail to recv reply for request
> /var/run/dpdk/mpdemo/mp_socket_1094695_b7080eff23acd4:common_mlx5_mp
> mlx5_net: port 2 failed to request stop/start Rx/Tx (5)


 Thanks for all your help,
Ashish

--000000000000712e7d06369cb4eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi everyone,</div><div>I&#39;m trying to use a second=
ary process to rx/tx packets through a NIC and running into segfaults due t=
o some data structures not being populated on the secondary. I&#39;ve figur=
ed out a solution, but it involves the use of internal APIs and I wanted to=
 check with the community if there&#39;s a better way to do this.</div><div=
><br></div><div>I&#39;m using DPDK 24.11 LTS for this test. The test code i=
s at=C2=A0<a href=3D"https://gist.github.com/praetorian20/0c1b69abbc7843d95=
8da72fdf611a5d7">https://gist.github.com/praetorian20/0c1b69abbc7843d958da7=
2fdf611a5d7</a>. I&#39;ll describe the=C2=A0steps I&#39;m following here.</=
div><div><br></div><div>Primary process:</div><div><ol><li>Command line:=C2=
=A0sudo LD_LIBRARY_PATH=3D/path/to/dpdk/shared/libs/ ./test-ethdev --main-l=
core 0 --file-prefix=3Dmpdemo --socket-mem=3D1024 -d /path/to/dpdk/shared/l=
ibs/dpdk/pmds-25.0 --proc-type primary</li><li>Calls rte_eal_init</li><li>R=
egisters message handler using=C2=A0
<span class=3D"gmail-pl-c1">rte_mp_action_register</span></li><li><span cla=
ss=3D"gmail-pl-c1">Waits indefinitely=C2=A0for CTRL+C</span></li></ol><div>=
Secondary process:</div><div><ol><li>Command line: Same as primary, except =
--proc-type=3Dsecondary</li><li>Calls rte_eal_init</li><li>Registers messag=
e handler using=C2=A0
<span class=3D"gmail-pl-c1">rte_mp_action_register</span></li><li><span cla=
ss=3D"gmail-pl-c1">Creates a mempool using=C2=A0</span><span class=3D"gmail=
-pl-c1">rte_pktmbuf_pool_create</span>

</li><li><span class=3D"gmail-pl-c1">Sends request message to primary using=
=C2=A0</span>
<span class=3D"gmail-pl-c1">rte_mp_request_async</span></li></ol><div>Prima=
ry process (upon receiving the async request):</div><div><ol><li>Look up th=
e mempool created by the secondary</li><li>Get port id for a particular eth=
dev using PCI address</li><li>Call <span class=3D"gmail-pl-c1">rte_eth_dev_=
configure</span>,=C2=A0
<span class=3D"gmail-pl-c1">rte_eth_rx_queue_setup,=C2=A0</span>
<span class=3D"gmail-pl-c1">rte_eth_tx_queue_setup and=C2=A0</span>
<span class=3D"gmail-pl-c1">rte_eth_dev_start</span>=C2=A0to start the ethd=
ev</li><li>Send response to secondary</li></ol><div>Secondary process (upon=
 receiving response):</div><div><ol><li>Call=C2=A0
<span class=3D"gmail-pl-c1">rte_eth_dev_get_port_by_name</span>=C2=A0to fet=
ch port id</li><li>Call=C2=A0
<span class=3D"gmail-pl-c1">rte_eth_dev_attach_secondary</span>=C2=A0and=C2=
=A0
<span class=3D"gmail-pl-c1">rte_eth_dev_probing_finish</span>=C2=A0to initi=
alize data structures. Without this the next step has segv because=C2=A0rte=
_eth_fp_ops.rxq.data is nullptr</li><li>Call rte_eth_rx_burst to receive pa=
ckets</li></ol><div><br></div><div>The above works but I have a few questio=
ns whether this process can be improved. I&#39;m using an Nvidia ConnectX6 =
NIC (mlx5 driver) in case that matters.</div><div><br></div><div><ul><li>Ar=
e there public APIs I can call instead of=C2=A0
<span class=3D"gmail-pl-c1">rte_eth_dev_attach_secondary</span>=C2=A0and=C2=
=A0
<span class=3D"gmail-pl-c1">rte_eth_dev_probing_finish</span>?</li><li>Is i=
t possible to perform=C2=A0<span class=3D"gmail-pl-c1">rte_eth_dev_configur=
e, tx/rx queue setup and=C2=A0</span>
<span class=3D"gmail-pl-c1">rte_eth_dev_start</span>=C2=A0from the secondar=
y process? These functions return various error codes when I try this.</li>=
<li>When I call rte_eth_dev_start on the primary, it&#39;s sending a messag=
e to the secondary that goes unhandled. Is this a problem, and possibly the=
 reason for the unpopulated rte_eth_fp_ops on the secondary? This is the er=
ror message I see from the primary:</li></ul></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">EAL: Fail to recv reply for request /var/run/dpdk=
/mpdemo/mp_socket_1094695_b7080eff23acd4:common_mlx5_mp<br>mlx5_net: port 2=
 failed to request stop/start Rx/Tx (5)</blockquote><div><br></div><div>=C2=
=A0Thanks for all your help,</div><div>Ashish</div></div></div></div></div>=
</div>

--000000000000712e7d06369cb4eb--
