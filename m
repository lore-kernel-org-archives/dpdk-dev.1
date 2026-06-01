Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75C9CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 21:02:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E3B3402EB;
	Mon,  1 Jun 2026 23:02:01 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 667F440150
 for <dev@dpdk.org>; Mon,  1 Jun 2026 23:01:59 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 8125A1D000D0;
 Mon,  1 Jun 2026 17:01:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 17:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780347718;
 x=1780434118; bh=R4ju24CHrPu+29spAaupClEvTxnsvycgYoIczo+G4vI=; b=
 Q1XQt58UDNy+3NP7UE2gkypfBaITqNecmzQ4zKEbIb57aejSbu6Spq69IWvvbv8l
 0AbfLx54aK/HR5nObfYDS0oUf3a8Y5QBeIh2iL1K8/0cUex7PilDOXG6outT6EBr
 0ELzCvEn+LgNe5qyCfHeO6Jyac3rc0oq+rjCR5YEH0L5J/ih/qUT6l7HcPThWJs7
 Rwy1ZvkYsgvfBgBjKk0tAzt94RCoCbtZ9f2U4CdHBSu/ii1MJEuYyJ8LeTGR0yS+
 SXUyhXPQ3tpiKd55o2dlM9YW2cK/sI0nNApQW1EGQAediP3lBx+6Y3VdlCyRfkCa
 9TDqYmRwJXIAYY/b1OhSjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780347718; x=
 1780434118; bh=R4ju24CHrPu+29spAaupClEvTxnsvycgYoIczo+G4vI=; b=S
 V2xNjVMcc1QZgYO77HYJl9Hyp8m8SbBWy5xLubm/S9VTxk4R0DkqhTNS919NKHqc
 bThCmBd2ijahTdjey7fuDyzSU7hUFHWBqfi1aUkoC2pHztKXTZNcpMXN26tRC1c1
 VvrdtF5jB/54YpXtAyGqpzqrdgjEaZf48bTnh8bUbjsT8L/mL1FOzQvio9fC/agn
 YxNhRZszN0KZYDlTYyxZVRVu417cNQFjg6Ccw6VLuQ4TwIcFNunQ892/lkpMzbRS
 QVZ4WiKRB7moxnF/ljJtl9BvBv5EnUXhBgp58ICPlaKm/HI+7XOk3Z5zlF5/2084
 KSy2po4cktECVQSU3DJjA==
X-ME-Sender: <xms:RPMdalHLX7wWmCnNm8ANI6Z0nFW67dDLFW8h2K4GJBNygCTkweB2Dw>
 <xme:RPMdalR2UIHwzG72c0qA_7Z8bz1h0rfBnEHnYZ59bSVa2_OPS-72-5vTErJNgOTI9
 0aYMk86goj-_D9yXx4_Nw5MbLmYV493fPUzBcOLAkwzZeQYnl8r>
X-ME-Received: <xmr:RPMdamJQClUxVUg_00d_0sSHq1Wh14setYT2c3BmBwtcWrQ53RjDdgwpPzmUY-MBx2hwOKfV2cM3bVfB6EBjyLq-BA>
X-ME-Proxy-Cause: dmFkZTF1EGvkzTWDcF2dx4+vB862YP8nM8YDxinRoiq49vR0kmeaew6l0pLS2rl+MsrK1F
 LmvnpLczCz/8M6CH0Xq0sjeqDFEtAkO7wRRLNcAs6qSAmMOXoJ45ZUQaAE6fZOW9LZooIA
 uVyuDlrtAmhdsu06aDy745HkCM0bSe8W2acC9nhPPKZwF1JhtnUXROxL8Z45i/AbuQ6+47
 VJ2l4iBXNrHxeiKAdH/g8TRwFHEBdKgkudfVFNCQNgS7UP9w5R/FAlB0LPQNvKdh2W3POG
 Qtsc8YrH4hi8PdNWA83h756Gbof1aisYG+F91HCCZp8OQ4qKogMRar3oq4IIlCjRNDTfqP
 agf4vFD2y9Di1k2kCpss4FEHHsXnCQGP2hJjtQRqJtyz+Dxx/412F0Zyjs72WkvfpSDAW5
 zZBpGWVIHdputIQffVGKVPcaS/FEE4hxLvkdT2Rjr9SaaomlKoBfbd2rurjboHdyTqr+yN
 A5W71TadUUxHDdHpNxppzx6XwuT82NpoiSu6hlyM1C37db7Psn4c2sZD/zTkA6k8QkKDDO
 KGty9Y7s+te4qnG8yLg5ZBZzEUxopJal5AJPvRY0b+kZJJOD0dX9q6xDlJYjyPb8HhS4iI
 8DlfogpDo33tEoHIiAJVSiyCT01cPnHwYU2+GD9m7lUYIymcewcVO7rPMB1Q
X-ME-Proxy: <xmx:RPMdagZKwo5wWTxOL42-nENa8Z7mp2VaI1FZZ4R0-4rS7tZVtik3MQ>
 <xmx:RPMdao_EBrR4Gw1rj5NXUQGqp88avNFBgFQOI5Uyp4sQKkwtpxAP1Q>
 <xmx:RPMdahaZ_X8vUlXOULViH2VFYvpx0CkazOZfHXqLFzgz2XeGGWJyWA>
 <xmx:RPMdasPGgNL-FQysTsavbIi_hPTPOK_Z2-iEOKck6Gc9omX0lzFoFA>
 <xmx:RvMdao_CQSt-b4VhszxUEU_Bmq2O2ZrJOafgebwYQyDO_A3fEjqH5vD7>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 17:01:55 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Zijian <zijian.oerv@isrc.iscas.ac.cn>
Cc: dev@dpdk.org, Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 =?UTF-8?B?U3RhbmlzxYJhdw==?= Kardach <stanislaw.kardach@gmail.com>
Subject: Re: [PATCH v5 2/2] node: lookup with RISC-V vector extension
Date: Mon, 01 Jun 2026 23:01:54 +0200
Message-ID: <FvISu5CfRJyuDjcpuWBNug@monjalon.net>
In-Reply-To: <20260505062142.575105-3-sunyuechi@iscas.ac.cn>
References: <20260331031059.2621971-1-sunyuechi@iscas.ac.cn>
 <20260505062142.575105-3-sunyuechi@iscas.ac.cn>
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

Hello,

05/05/2026 08:21, Sun Yuechi:
> Implement ip4_lookup_node_process_vec function for RISC-V architecture
> using RISC-V Vector Extension instruction set.
> 
> Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
> Signed-off-by: Zijian <zijian.oerv@isrc.iscas.ac.cn>

Signed-off confirms we can apply the DCO rule:
https://en.wikipedia.org/wiki/Developer_Certificate_of_Origin

For this, we require the (quite) full name of the contributor.
Here I feel Zijian is not the complete name.
Please could you help by telling how we should identify you
with english alphabet?
Thank you


