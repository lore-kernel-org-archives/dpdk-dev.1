Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3999ECC6B38
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 21:27:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C351400EF;
	Thu, 15 Oct 2026 23:27:37 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 00C6C40041
 for <dev@dpdk.org>; Thu, 15 Oct 2026 23:27:35 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 866ED1D00124
 for <dev@dpdk.org>; Thu, 15 Oct 2026 17:27:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Thu, 15 Oct 2026 17:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792099654;
 x=1792186054; bh=urHbCDYrjUH2jf+jqtPl3XUEOR/yt1UszXN0kI4avx4=; b=
 mvQrz7LboQ3v5XZJVJo40AEbPFB7gL9EWzoK/bA95r4Txzzmg6DIYI++ubqeuQ6G
 u1VbAR3z6zid12D8AnPSzXOPUse0nRUHUVaTJcuIXirxTpMt0MvJtOVRuAPK7v5W
 74B0UM9DU+pksm6/uNiUGPkkHgUDr1WS1fq/ZYASPakxQ5ApToGO4XXZx2iW4e3e
 GxjfmFlYZzq/54+hASalqrfN0d+xqCs07qI+52QwFM6qBVuXPU/+fG0hJAGNoVTJ
 nF2pzlnb+xgReWoyMedH847UagAJUlmSO9cPodRqZ1Dn2cHmV/8TVgxnKi+N778L
 KLEUuqfn04JDGKaV9OGIkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792099654; x=
 1792186054; bh=urHbCDYrjUH2jf+jqtPl3XUEOR/yt1UszXN0kI4avx4=; b=p
 xcaU+jezBZ/Eaq36d665Z2p4ZOrAVQq0wZ0+wkf6i7zgpvyxCUYVH+JDJnstBrXa
 aBaLyvIyzpbrwclWdWOafwF75T9eT0DBgncmn3IOT0rcYv+Gb3pZ9BZcPZJDA1jl
 6cSS/kGHEGqjirSo2DvlLHhc277peNlBACCwijWimu4SYf1SUs+MvNGqqjsyOrJH
 aXhCOLXIwrZO9Av/xcadEVX8+9ALiurJ1/aU4dtTVk73uT6319aVHv2+qTVcH+0S
 sXVbrAC5kNBSjR+CxZQ4vtwK8zHeKnYmwjEGa4ZpUyviRWF1aGt7g8q/QpAlHtZe
 9njfG05G/vKsQInaGIsGw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792099654; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:GSXqJ61Can+YDtg7s+yVbQxX0xcf3ARfnXoVYGnGopo6/wA
 yZANVw+tTHhQ3KYQ11iSTxF1uxF4LkElzfeX7Qm74CynKtfwXrfRkIXPKIryXP/T
 3fg/b+mVXJP7sVpU1k8xJhLX5SQEBb76PrMfzc7DK7Mp5oZSdbcs2qjkscA9CFUb
 1mU0qlObYEKRUQ1DNizqnnopjhY/GuQPyOmLWPfWDX9idZ3x7hrcHWv4cVQozaJ1
 MetEAjbZAwj9DhIP6IrggGdfuq6/MLl6vlLYdVNErxSRE41LmV8AZ/ED9DBrrtjI
 6yF8JFvyucGSELRzO9pCni5YpOxD+B0tpUPme8w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:wgDGdeE0lpFlj+qGPAtvZohBUA7qEPRoFLXDhRR7zX0=:gib3Duab1Zk5OeL0BLTr89V7RY8iXWbD72ZH6td+EEM=;
X-ME-Sender: <xms:RkXRamlqEWLhqmxWsEy_--rEHA-fw6nnHPmyYzgn4DwIkd6G6otptA>
 <xme:RkXRapTyZtxnSnUOD9qT6YpouQlWg9DYipJtN8ZgBZ198fuEKF7hHogad7ovBM_zl
 lJ1qDUpMyX6pHusEo3yDpBz8DjlDeXX9W53uhC8BZnh9E4OqoCZGEo>
X-ME-Received: <xmr:RkXRaoJUIda01_gBjsl20lc-b-krgrBdAykLUE6eQZU85CTaFrABLcq8t2lsdMjwZpnRJ0lE2w-P4cf8dduPlvE>
X-ME-Proxy-Cause: dmFkZTEE4RLoyGSojBKYZxopkizGOh+/NQWPTevYgWcAi/S9s0sttABecW/2oJLW6fvxAO
 UyLiha9v3ZdYBElCWNeHEraEXk4zqIiO2RFUFI5S1VBE6uQJxss1d32tWQsiIvBfVZR/JT
 RklSIKuDhn01OeWDvFHPejoM/X11lBZeDEEU/WmwX3Cg0W1pVqYcJZ/bV/Ff4Xap60pajT
 2wckFwKT1NN2Pb/OJnFqr2XmB8bbwODVOo52Y2wEy+4FRGrLXfe1hjkUbMaVnlWd84MZtu
 U/ZUtdO4sV1kXmeTxM51FzaT1ycAAD2MXZzMZtP8WpfX+D4N0Jxrm58swQE+dIhFzHUztD
 hTlmPE0jOVpzxgLa1sxTnhhJ8sWH2/YmmkhqgYswq3eU4oXQzMIqMau6g3TkmIuXU9Y37c
 Yybu/UeewADEZ0ieXxYyoSjkPjbIgTh0KQTlZZoxfbfKw9ZFIilMtmTITgHhGAUKgrw8iF
 KGUrqSVF4S8Xkf3T3duyrU6frzoVt8VQz+9y6pEhKtCRxmXzFiUVx3thlXxUkAZdVDpY4+
 7PpZJ3rZQSy+ytL7KdeHW/9ct8E/VapDF0HfY686Gr1hV3PRQBDawBq6FJaXbMw3RIwnMn
 zHhNfTVaXPA6jf3/yhnkqAuZauLjqQpIM0/iv9tsiXms19uDuP25oysjhXoA
X-ME-Proxy: <xmx:RkXRavCtIt2GNVBvQLiZZf6Z-ahIfgUGSkgvvreyqnJvx4h4wHP9Zw>
 <xmx:RkXRahBCXGzNmRjjAykka9yemYkNCIt9gogIy3gHOOqw7hTO1a9M-g>
 <xmx:RkXRahCrA1NIvemyx7a2SE4pK1k28l079P_P1yztJqUbLbgxkPsDvg>
 <xmx:RkXRasryFWxAB52VwzmuOHuWx6mM2kwsz5QA0sMvC5WoyUg1YUWe3Q>
 <xmx:RkXRau0cKTOYcjynIZ4M6kivhFr-GwnEuBJXKM8iLEE2ETktAonPO-42>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 17:27:33 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <qm2k21@gmail.com>, Marat Khalili <marat.khalili@huawei.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>, dev@dpdk.org
Subject: Re: [PATCH v4 1/1] bpf: make bpf_def.h private
Date: Thu, 15 Oct 2026 23:27:31 +0200
Message-ID: <Gfp9wHcVQ7KvVFQpxSDtuA@monjalon.net>
In-Reply-To: <20260918092117.74231-2-qm2k21@gmail.com>
References: <20260917151916.48749-1-qm2k21@gmail.com>
 <20260918092117.74231-1-qm2k21@gmail.com>
 <20260918092117.74231-2-qm2k21@gmail.com>
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

18/09/2026 11:21, Marat Khalili:
> From: Marat Khalili <marat.khalili@huawei.com>
> 
> Both `bpf_def.h` header file and the symbols it defined were not
> previously prefixed with `rte_`, creating an opportunity for name
> conflicts. Status of the file itself (private or public) was unclear.
> 
> Move public symbols after adding the necessary prefix (`rte_ebpf_insn`
> and `RTE_BPF_FUNC_MAX_ARGS`) into the public header file `rte_bpf.h`,
> and make the rest private.
> 
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Applied, thanks.



