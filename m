Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12058CCA464
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 19:23:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43F4D4027C;
	Thu, 15 Oct 2026 21:23:42 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 9BA66400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 21:23:40 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 0006C1D0014B
 for <dev@dpdk.org>; Thu, 15 Oct 2026 15:23:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 15 Oct 2026 15:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792092219;
 x=1792178619; bh=fbiMczue232UfwOIxvhjt4jrXXOurNMGQCPqzK/b0SM=; b=
 ZNz7FcvDmyZT+EfToBqlcpG2TWeDu669BGXrSdja+F8Kq5cKMIJYn2JTXE2Gs4eF
 GwgbZHUnfJ1B9xHRrBF9YbMRo5JpKCU7Xjjqj0PqrwEotdy/ogEueffwdrF9Wiyn
 TYiLZegKx2IuSGISi11roXOW1/Q/lEBzrrj0keJcAmq7YVM+YRVlv/BpEAVIyMqS
 JPl7Lqt9j/khwiF/awfNMmxICtGFQQzTsWoCXpqbiNRKWPLfEvbLdQFMLyiJTreb
 Em9/eNYXKRd2D/p/OHWKXt84yk9qgpMeTR5m8pQiqKBrBD9rotGiHC2lgBoT2jaV
 G9xd5e5TVMUoAwD2RmTIVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792092219; x=
 1792178619; bh=fbiMczue232UfwOIxvhjt4jrXXOurNMGQCPqzK/b0SM=; b=P
 L1eVCYEimXYvCAq5xbLAw4sYMCThT1Vc/drShwn64xRzj8JcIgFjhCwBqDRGt/uE
 oSQbTJiwnEBSwhDhzURhet4xOc28PfyQN2XygiZ1jeZ4yvUJYduYBj4/5I6r31MK
 eExbyRmRMuuxTUjdJoQQCqDKVeoDa9zQM2gGBdi0fTKRWeqCFyzmMiEQlwMx+ObV
 f11Z/vz4LAXUC0aosN7tM6kn59mKNeuqJBn/k1sqLE0kr3KCgiUEBq7v6EyCya6N
 hEq/x2YvqeuIcci9H5xZf5JHw9s/r4AEL19GkxXBUgNvus1HlggGyoVH644hlOH7
 SIh5IR6uZfXY/hlZkGbrg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792092219; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:JySDbAuzVz+RepAUEYv2qZyY5MNFT8TGOX3r5Ovzi2hQGn9
 AErR8D19+e29ASYvPJfk75cz+SIsAwOFo3oHKfsBibo2k+5PRskFjrEHvOpVRTH1
 ink9HQm0YYMGJkDD+PxQ8ST1bp3b0ZHGSFvmY0UKrf8sy7LhPDj6BJMXbv0AuVFb
 veDzdFyXuz0uui7Vg9aabXWCSKrk+p68vI9ztRUnkk+XktxaZCNue4Ujm+uNj3ZF
 1FU0wgVaGBDZZVPcNSmS6MMmwfOZxMMVjRCZHSr3FXonwhKsgA8pcKlh71w01slD
 e9v/KIfELYqPiVjxCj4whsMeL86Ow4RoOUK1qkw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:V6D83ecMDTuDJJ7QhIXSUAuE4HiNKUpQXbzRyERkpkQ=:IPc7GL5MkImCsH8pB6bMjO+17hyKDApgHW4QlOcyLvQ=;
X-ME-Sender: <xms:OyjRagHjf31dwj9m7ohMKBNntl2s7UqXvfVd8aYnXoggrYhgqj1t1w>
 <xme:OyjRagyFJCrFU0H5jlohpZRAKM_tHBQ7YXIbYjwyu0zPHCiDDK2ZAhlqxrZkblFd8
 X2GMZS65tM4T0zdLfX-K1cz7_Ap1Ctxi29Ny8xalw5o9s40YDsmt8AO>
X-ME-Received: <xmr:OyjRanh2owSG4spwHMxWCIwqSPUCT3iKmG_UDnoAMi3519jbW2T0rRcHmLfBhWg>
X-ME-Proxy-Cause: dmFkZTGGWOXlSBt0HuVb/Km54Ihj5fNbBVfAd2obsGSq+80oHmauHMan2qLAKqhUN2DrTI
 pUgGhMNx44UMsbd4yFR693RXKbu+AQ8KxjJEi8kZOJHKUu2hVs1TDLPh8TsmdjHuqJLXVU
 APzyLbY+KRHdsFbu38EQk9nPthNmFA3LElkWQxzwUipM+Ydg9Qr8ldJKxlQOcdoceyU6+y
 0KMaUWXib94rIRiry0I9hCj+c84Zr14Xv3HxWdFghKNUtM6YIEHFfHgIHo31wmrPd1oZiI
 8t7aKoU8YTcZXeKvHFi2+ElqosG0xefWF9xRlkxHQAzp8pU9n30hsCnEw3oz0QCoVlTpMA
 Jc5WJ2SUm+eVfex9CcTNxpdODj7ORfetIYdkBIPzJEoyp699qjUec+o6XW2ywsVynmNzF+
 6RrjJjar1zIeIKyUi8sCwLPk6+zQwbxEd9KW3dLBDxHtPFH/E2s0PGhgzWn9glwEYxN9G2
 zHywa0AuUs8J3//Nf0gMFFS8Y/TdAp03gjsAf+8zI7/8k8c5kdQp5rNRy+GyExNPceLcjv
 fXqYmQK8PkmTLCEQVikpXIGBH8CdZu/MfJlQlHRnZQkaT7XzNicQ24/ssdv5eWGL9L07kP
 1pNGVZjZuFugYmgqsWMJ6K3Smeg0NTeL/XrbxiHGv3uZu3NxHyj75U+IDQDA
X-ME-Proxy: <xmx:OyjRarzEcwWnkcjBlK9BNroCBo0-lcuW86Fzs23eDLgAMTltJQFYLw>
 <xmx:OyjRaqInvSRAdHiZ5Mo8HdmHCkv3LN_XJIi-KQ_6o3C8NeXTTAKAXw>
 <xmx:OyjRaiTtDqYDdvvNFdWJa0UlvxOF-7vfh4o7uFuGVfbLdWbWvmEXmA>
 <xmx:OyjRaipabGAmUnRNLFjhtnHSW33xhHjS51uXiM8lmNGLSPS8R-YkvQ>
 <xmx:OyjRag5pI1-JDVE_df1wTvGBn5pkUBlaV_GVQZRrdoKgEuvtq6wo7X6h>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 15:23:38 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Sun Yuechi <sunyuechi@iscas.ac.cn>
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, dev@dpdk.org
Subject: Re: [PATCH 0/2] fib: fix and speed up RVV lookup
Date: Thu, 15 Oct 2026 21:23:34 +0200
Message-ID: <l2CUUG0AQFq25zvjYO76uw@monjalon.net>
In-Reply-To: <cover.1791183388.git.sunyuechi@iscas.ac.cn>
References: <cover.1791183388.git.sunyuechi@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

05/10/2026 09:04, Sun Yuechi:
> Patch 1 fixes wrong next hops from a FIB created with
> RTE_FIB_F_LOOKUP_NETWORK_ORDER on RISC-V: the vector lookup read the
> addresses in host order.
> 
> Patch 2 removes a register spill from the vector lookup loop by
> gathering the entries at the width they are stored with.
> 
> Patch 2, ns per lookup, standalone benchmark, tables in cache, -O3:
> 
>                     1B     2B     4B     8B
>   SpacemiT X60
>     before         31.1   32.1   30.6   29.7
>     after          27.2   27.9   27.6   26.4
>   Sophgo SG2044
>     before          5.6    5.7    5.9    7.5
>     after           4.4    4.1    5.0    6.0
>   SpacemiT X100
>     before          4.7    4.8    4.8    5.9
>     after           4.1    4.2    4.3    5.1
> 
> fib_perf_autotest, whose addresses miss the cache, gains 0 to 14%.
> 
> Sun Yuechi (2):
>   fib: fix lookup in network order with RVV
>   fib: gather entries at their own width with RVV

Applied, thanks.



