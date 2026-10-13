Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AB2CC6B0E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 08:20:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9F4740272;
	Tue, 13 Oct 2026 10:20:14 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id AC40D400D6
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:20:13 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 33F1F7A0106
 for <dev@dpdk.org>; Tue, 13 Oct 2026 04:20:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 13 Oct 2026 04:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791879612;
 x=1791966012; bh=Ih1lAQ3M4cIl2DhHXb6Cel2PkXPCSjAkF66jFEeX3m8=; b=
 X0Ts6hZc1AxFRumIhJdFcQHfNxXZ+Esn60fdzT8JnGxpYnywTWok/A1SMTLyy52O
 1TtFqN7xZromXLuBOSUIHxjNkeaI86ZFHa4h/ObTYiOQKmmVsCPodQ15znEdsv9j
 uSMua/ICf22MA7ksDTHh+xIGUOqgZ7AbP+AmdGromUoeX09zSowON9w/aBHcGAui
 50rrxoxpJ4tUFz9Ti70qaELS8XBa1suGdwqXSw5sIerM+L21mQlFt1MXamsMMMGo
 HK125fYtRVqgwVkmKsGTu7qdMStfYbxBz9Iw7jH+mLTwPoxTq8sbbFmtG2gZypGC
 FSKupVmcq/E460Isxqhrpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791879612; x=
 1791966012; bh=Ih1lAQ3M4cIl2DhHXb6Cel2PkXPCSjAkF66jFEeX3m8=; b=p
 np7J1xMy1HSWUSd6YKPZBb2p/bW6+8DpHdmw4W4PUd7MBsfuEGb+5SgTOLeaXInI
 IVSUQIRXwRdlO7ICFGmnATp/LVt74URopMOL7I2EXXc9EJs0UO6VFcuOs9JxkG07
 tVgN0Z4M2TXuDiNgqVOGri9Wok7/++CANF8CTdwQF2uZ7ob3mE5c0ihe8+TAo2Kc
 lGZaGEqpA4SWhi+QV1Fm7Q/AvVdp1TUAvxRQ219aYnjwdUTcuYOCrV76dugK4Onr
 auPsroB8bOTepoReAHEiNOrer5kcMBY32p0mXl35oPz1NYp9Obyrp6PZd/C+oWpO
 6TiLVnRG7M5MzJcI3+4uQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791879612; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:ePiJ8/nFPjSKS8lAwkLRUiCbfcrTh/COcIZ9wZCLYBW8W3r
 ZmO7VkzdJXPxapONHv+U5N5j+fmf+LKMZEuOeatb26I0EtRXgKa6rKGodU+tdsR7
 7NOcIbBGeeGQvdE1J+BOdpHTLTWQBpzT0Ua7iA+AvM3WZuqNRKh8khrFdajoXs0d
 CVVj690QO1ZwXMstYxeLPx1rL9d/lKJTeKF+CQl8Q091TxR1ctp+N/OeZlDPFuSt
 3n2dKvukCFFvVqLz2TJqxsJJGqjQ+OItQ1S7Ex/qsKqtIxi967pr9TzGTwgfD73K
 JSSq8l40i01zuAGZ9PB1llfEVxGcJOT1SMtZlaQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:O+7KK4YOTKBlLy+8sTT+azUdMVHpF10A8Bms2Zrtmdk=:XWXv3PaA3naq2KyupAW8tD2n5/MIzUwH61J0HDEPWQI=;
X-ME-Sender: <xms:vOnNakoE7KLpCACoOyzD8afPefCIpz06vTuQcrhvQPrLWzXi9pKtbQ>
 <xme:vOnNamGdJtnXnZu-sPwdefMWLzR5CJfQRXgnuNLSrRXBnEDJoikKTSxfYseiA7QIo
 zp1xu_H7_mQ6ewNIgPl2Bno4sCAOxaD_j3dDj4aWpkMLrqaisafzV4>
X-ME-Received: <xmr:vOnNass7LeLKBGF4Gdy90HxLeJXEtoUJRQJBDBmbsEvnmrl84EekTJo1BFyFVrfTfldocb5M7-GDpcfHxqfzc2Q>
X-ME-Proxy-Cause: dmFkZTEMrb/gK24LASo8R+AjFqRTKbZyR4FUFqLuVyLfrdBgwBRTjAAqbmUwdkq9iwErVQ
 JljQkmCYUItv3kUc57lHkfFHgPb9swENKgtsGwCZbc4fNzRdmgmQlRQ9LmH58DOEPe/yPl
 aPyHVKtQkxszN3SidJpCNPt9g4hTVvFYfEBZNMsaXMElR7dBUvITaqbI6bpHcrrEC8uAIj
 xUKC+GpOV2XT1HXfD936g5HF/UuLIWWzG7Cb6aHB81SeLrhOihj06UJxGLLJMFMVwTsLti
 OhPQ/K/ljNt02OkfCApPmowUdxm9X5CYaVHgVaH8Nsk5rEQTy4/jJKnHjoLFim4PZVQskT
 KgUO/MCtmBr48AFZ0B2PYaG7cGMfUQKwwyW1qIl/L8NGFFAytMp/LlSD+LPu3ZPPCyzAi8
 Odlqkfu1o9/sWVVpBWUhlpKOVHNc9igSXOegyquRp8uzpFpI40nRcdqYWNHncbywuojX0a
 iPV9PQ+Y22v1wPql8vIhho8fomrFHc3+xarXwYaWkExzYwyCxH0cPsf3KfEYgZrHbVKV/s
 Gwxnx53VVIRQKMcBPocMHghFwNHHR7Ix1rjDJ1SCRy7Dz8xqnC2rIUpytBw7dkaBI8K7AJ
 h1T6IwjzzVJvPtV9y+ExCasxf8UdbcB8ZAMWPghspWrwMuORjb+O9j0dzxNw
X-ME-Proxy: <xmx:vOnNagW-SzXjDQ-5hrs8g6qpx_J_0zsc5fUBtfWFFSPrmKyRkKlfNg>
 <xmx:vOnNagH5puOopurL7d0o4jJeLIhgzEm182Beg2WJLt0zR5SDg3lFyQ>
 <xmx:vOnNaq0VXOLQTnWLXYJmtikox6CtU81ccItbrhsf632di3el-wcDvA>
 <xmx:vOnNaqNlQFPU1HQYItCH-URiVnfA_DuXpazkN0hJrvwWFkekqWODwA>
 <xmx:vOnNan03qz8hR8dD6nY6Gd8V0Yy1BLcs6NdS_aPkrBnDf8X2CSwvJjaF>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 04:20:11 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, Ravi Kerur <rkerur@brocade.com>
Subject: Re: [PATCH v3] eal: fail initialization if TSC frequency is zero
Date: Tue, 13 Oct 2026 10:20:10 +0200
Message-ID: <AkjjTVT8QVi8erXmCOhnBg@monjalon.net>
In-Reply-To: <20260929141423.309936-1-stephen@networkplumber.org>
References: <20260928231637.733450-1-stephen@networkplumber.org>
 <20260929141423.309936-1-stephen@networkplumber.org>
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

29/09/2026 16:13, Stephen Hemminger:
> Many parts of DPDK will fail with divide by zero and
> other errors if the initialization logic ever TSC hz was ever
> determined to be zero. This might happen on a broken get_tsc_freq_arch()
> or bad emulation in QEMU.
> 
> If TSC hz is zero, log the error and propagate back to
> fail rte_eal_init().
> 
> This fix doesn't need to go to stable since it is a purely
> theoretical problem; we aren't getting divide by zero reports
> from users.
> 
> Also, clarify that DPDK TSC is stable and the same for all lcore's.
> The comment in rte_cycles.h implied that it could be different per lcore.
> 
> Fixes: 040cf8a41187 ("eal: deduplicate timer functions")
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



