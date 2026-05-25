Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31FCCD5BB1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 19:39:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2C0140280;
	Mon, 25 May 2026 21:39:24 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 48D4C40144
 for <dev@dpdk.org>; Mon, 25 May 2026 21:39:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779737963;
 bh=0ENh+WRjQ88kBheX2TFpNBuuJsEtNfABWKeb+sI7zKk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ePFECMqsxOXbEvzpTsIEoFRmRvapQ30ofyIPjBXEM14Q3l9FIWnJPQ7/bF/cpxil1
 Xwk7PwrMa5FsqMIf22xdJgzuIIy8MLDTUsVFp19w50u+PO6Oy7iPtk1dhEsdRLXlTA
 geVYZrMVNdsxHcs/6//r+e/ZHqQASZKyiG6EXyYDtPtdkwNgNVxe+SwAA0abtYk8RM
 v6Vz6viyWq+UrdyvpcGmXmAxb5PmRR9B1i1ClzwGQcrOnwvk6W/0GFMDpAJKhqhkur
 JO1jtXls0Lhs+jlc7O824QGMXaKKVbN/ViIcmV6UqsZB4Sie0/33HDCLMQUcQUNLy6
 pZ/p/kiPaYizw==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id DBB081ACE9
 for <dev@dpdk.org>; Mon, 25 May 2026 21:39:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779737963;
 bh=0ENh+WRjQ88kBheX2TFpNBuuJsEtNfABWKeb+sI7zKk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ePFECMqsxOXbEvzpTsIEoFRmRvapQ30ofyIPjBXEM14Q3l9FIWnJPQ7/bF/cpxil1
 Xwk7PwrMa5FsqMIf22xdJgzuIIy8MLDTUsVFp19w50u+PO6Oy7iPtk1dhEsdRLXlTA
 geVYZrMVNdsxHcs/6//r+e/ZHqQASZKyiG6EXyYDtPtdkwNgNVxe+SwAA0abtYk8RM
 v6Vz6viyWq+UrdyvpcGmXmAxb5PmRR9B1i1ClzwGQcrOnwvk6W/0GFMDpAJKhqhkur
 JO1jtXls0Lhs+jlc7O824QGMXaKKVbN/ViIcmV6UqsZB4Sie0/33HDCLMQUcQUNLy6
 pZ/p/kiPaYizw==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id C25711AD22; Mon, 25 May 2026 21:39:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779737962;
 bh=0ENh+WRjQ88kBheX2TFpNBuuJsEtNfABWKeb+sI7zKk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=P4ggVBXtZuNx4NzQHlybV2niTNMas920rBR/TbleDebiCeT6DmwNrXDR97PhjrH1l
 6eSUS2DXoW7Ot4tlp8cCSTtJS2BKP7K3PmLJ23kL5FwajbjEy6kugV/1MoIOrizTIJ
 n46kfZnVk3LEjQUVSxlAbvttCriMgsOgsrGJXO0oWMuzQQvoSkfrwu3b2HHjEA8Vk4
 Knn1dNYJFphqr4vLK/nqutxut6FE07palgd25b8p+IWA1G1qUiwmNPa8b1BMZPmaXT
 YKxVFLQWTKSPkAYnMGXR1YvmTS0MoDd3ncftN08mtN32G/WB+29OXyNWQ++9pglFmT
 WXDwNGImHCzsQ==
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 5EC171ACE8;
 Mon, 25 May 2026 21:39:21 +0200 (CEST)
Message-ID: <af3a4738-df30-43c4-b3d9-5ec1912a307a@lysator.liu.se>
Date: Mon, 25 May 2026 21:39:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] lib/fastmem: fast small-object allocator
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Yogaraj Baskaravel <yogaraj.baskaravel@ericsson.com>
References: <20260525103642.55255-1-hofors@lysator.liu.se>
 <20260525073029.235b4d40@phoenix.local>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <20260525073029.235b4d40@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

On 5/25/26 16:30, Stephen Hemminger wrote:
> On Mon, 25 May 2026 12:36:39 +0200
> Mattias Rönnblom <hofors@lysator.liu.se> wrote:
> 
>> This RFC introduces fastmem, a general-purpose small-object allocator
>> for DPDK. It is intended to replace per-type mempools with a single
>> allocator that handles arbitrary sizes, grows on demand, and matches
>> mempool-level performance on the hot path.
> 
> Makes sense, what a simple wrapper inline to allow full replacement
> testing/performance A/B comparison?

Do you mean a mempool or a heap wrapper? Or both?

I haven't looked into what options there are with mempools. A mempool 
driver should be possible, but then I guess one might attempt a 
whole-sale mempool-compatible API as well.

The role(s) fastmem could serve are:
a) An lcore/fast path small-object allocator when you don't know the 
object size and/or count beforehand (i.e., what the cover letter says).
b) Do what mempools do and a.
c) Do what the rte_malloc heap does, but lcore/fast path-friendly. In 
other words, option a but with larger objects too.
e) Something that's both b and c.

I haven't really formed an opinion yet, other than that option a seems 
like a natural first step.

Fastmem is significantly slower than mempools for the moment. Claude 
will tell you to inline, but that doesn't help (at least not in the 
micro benchmarks). Then it will tell you to go remove the statistics, 
which also doesn't help. (Latency is data dependency-driven, so stats 
load/store/compute runs on resources that otherwise would have been idle.)

What does help however is pre-compute socket and bin-related info and 
put into a handle, which the application may optionally use to quickly 
retrieve objects of-a-certain-size/from-a-certain-socket. Still slower 
than mempool though.

> === Scenario 1: Single-object hot path — cycles per (alloc + free) ===
> allocator             8 B         64 B        256 B       1024 B       4096 B
> fastmem              16.9         16.7         17.7         17.6         17.9
> fastmem_h             9.5          9.4          9.5          9.5          9.4
> mempool               6.9          6.9          6.9          7.0          6.6
> rte_malloc           93.7         93.8         94.8        100.1        130.0
> libc                118.8        119.2         20.4         20.4        111.0
> 
> === Scenario 2: Batch alloc, FIFO free — cycles per alloc ===
> allocator             8 B         64 B        256 B       1024 B       4096 B
> fastmem              10.1         10.2         10.8         12.7         14.7
> fastmem_h             6.8          6.7          7.4          9.3         11.4
> mempool               4.2          4.1          4.1          4.1          4.1
> rte_malloc           58.6         58.5         62.1         67.5         68.5
> libc                104.8        104.6         73.7        203.9       1254.0

Intel(R) Xeon(R) Gold 6421N / Ubuntu 24.04 / clang

Best regards,
	Mattias
