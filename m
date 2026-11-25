Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D34F606A321
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=ZPqVptm3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=O4rWPZL2
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B553A4027A;
	Wed, 25 Nov 2026 15:57:42 +0100 (CET)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTPS id 4EA4940151
 for <dev@dpdk.org>; Wed, 25 Nov 2026 15:57:41 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 36EACEC0CBC
 for <dev@dpdk.org>; Wed, 25 Nov 2026 09:57:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 25 Nov 2026 09:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795618660;
 x=1795705060; bh=4zp12ZhW35PA0y7atjdv/sUSYYATGkSSdRaKzoqV1YM=; b=
 ZPqVptm3kyXU/lKfC+UE8X4reNa/vPbgITPz2Yad85Y3Y3Ija2se6zzHV3ur26c6
 0U2mnr87aM78dUkgv7LdAheVCekHOG5w9YOz0UG4yDGYDf0R+7wpEdqFXpQ5E+lZ
 VfgDmFSle54DSj49dtzskPRB5XXS2lVD64YVUoNa8Bytl5/udfwuZsbQd2QPezz/
 rc+xd06YoEo6lH4EhVfaGTtHl0EjDpuVkl7JcJvvvlT0spvk2c7tUKh7Y+RP0k3W
 5cp6rfafFt/CpGHlUm8hR69z8xaxOoyCnFzaxdklXCf034kqChOOBDMIPm1lybbx
 q5Akzn7DfEYruDkRxcZdoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795618660; x=
 1795705060; bh=4zp12ZhW35PA0y7atjdv/sUSYYATGkSSdRaKzoqV1YM=; b=O
 4rWPZL2AhSZt7RWgqmZqcB/LOMo8vPpRKhdF5hl7xvgobQ9Ai+LUC/slwi6Lorg7
 Y9imNSaxumdDkUqslgwfjlM5sgtChf/UT04jdn8EExgABDAB1sBl9ULz594tdA/8
 ZJAw2gL2S3bKC2hF1fMCPJQrGAPq7FYLuHw6eiLPGpSKHwtIspB1hxE6RUFW5XXa
 TkEx7v81NSV2mQCrSshnPk/yUGQ4BcqgvuB3QTxWWNefzkmnaofmnLXu6/EDDY+n
 tFZ8c43STAJYhHyvYG+69LRRB6ro89mn2uJJ1WQ2fuaNRIayXKqMbylboCMllrw0
 NmsqpCFQdyrib9Eq1ouaA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795618660; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:W2PEd6AqzSxl/c2bviCPegceYYyJybtFjT9hTrTnPobnUn9
 HN2KnyIrsDE4pqS+v9OgV6ziQBZ1wVvuK43kzuBK15r4qUTxY/BN0TxrP+lnb8Pv
 tCtS/8zGK0UbGrRMDfrLtS4wE6L9vmJB62IpicWGK+5Qy2KCcV2KWNU7Vo8/4Oq1
 NE6V5IfKumF93/YSPuuY6TZSuwFfJOmNbIrjquor9PZRNOV/vOv7DwbSmXEK3Bye
 3odmXYyvwAf9XDBuMLKhNeyqaVeu0ChUlix1uygmGf/6RCKI8vhSQzwzqmscbuBZ
 U3VNY2wSA2lTaSq6wlAFGq4tZAOK8FKwb+j4UHQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:WorORjxpDoqJuqn4ML8GtDEqVD+ZU/Sg/m/jAbO+Vx8=:+f80fFrpYN8ikeSd6Be4K2NiYb8wmHsEd0KwoVSK1KU=;
X-ME-Sender: <xms:Y_cGa728MK3HUAy3AKQG7sJ6DFnJygfqFh1MhONUrLdkPWguuINgug>
 <xme:Y_cGa-YVJgmFNtFsENMS3t2SYPUF71upMmPuQkP5rtzXy3BFrsmImumdCaGIlN4nt
 zNNaymEEPGB2nUKWypP4leQcerHh3iktZOsvVL4eFisQcqmg7KlmX8>
X-ME-Received: <xmr:Y_cGa7CpgJwJo0SOC1dibGo1dHapN6bc16vwXSLmea2xg0z9HarIEtPMGd0EPdj74XUI5oeE5-XqwVg3B9lThis>
X-ME-Proxy-Cause: dmFkZTEkeq5KEvMS1zDt+SUnZPZwuqVpqIFdG8GCqVhmA+IvrY2+aUSMgL38bdHKXTupiz
 W21PEK28WXO5X4Z96w6qctP+uCIFch69QiF2RKjizZ9NookQKxrQcch9Fi9iEa0LlxarEi
 TQ5M4WVcA9qphFMvDGPb1auHASk41AiKrW6cOIBVwFQqm0rxdXz49xcfcFvW5QABgB0iTy
 0mzJrsrdq0Spe26kO9h9VHxPMoJmcgiG8oKON6kjWHvsOtCRcob9y9t1nymlNF4CNtsOKR
 Z89teIgZb46x46edQbvq6v8R7UZ887bj1EkUanOda8DmwuGKBWd+jbWm5sk6DiEriDXtEN
 OUAvKB2rbIo0KAwcK0uA5OOXOKBPvei1MBEYkIbKcMxYawiawoYziUxX/uESNGoUB5jRfb
 DjlhS5fPqXyGu4Jx20+/XYk1pOelXTVhA9T+grKQbRUYAv779zYHP8EaRKCx73gGY8wIPL
 ZRWQEiUawChxcc6mT5Z76eLvU/MCR0mBfPi4FrzFbbQyvG8xWtEvlFt6cdad2hWoHtZaLW
 s+invGvbDl+/hx62y3BRsOKkrn3ZUTaKyS9odM+tPYh7n1kPjQBf32e8lLmf79TRoBE92j
 VOiLQEmyRDniYTsUldHrney4JmWDwYvkiBnImFLJ7g8fTiSDTkBh7Dql1uMg
X-ME-Proxy: <xmx:Y_cGa49XTvv6QTCwA_OE_LuJqXmDEEp5BfRpFSDE0xaEhnp-Sb0p0w>
 <xmx:Y_cGaz_KV1GQXrdFTOrUv0NZqFlxD07ICbZQe8PteP2etu_eLa9MzA>
 <xmx:Y_cGa3c69H7RyEdm75xEUtq6w3yWxwagOWVULtS-uJU6vnnYZ61Jsw>
 <xmx:Y_cGa0FKmfx6Eb3Sa8jdHiCYdGk774IRPzV-EMxmTwpIvHdwHCxdeg>
 <xmx:ZPcGa1M3NVc47W8qioTt5lE3PiqepddbwQWkwLptuWfKX4m14CpvPZOG>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 09:57:39 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com
Subject: Re: [PATCH v4 5/7] doc: add missing globs to doxy-api.conf.in
Date: Wed, 25 Nov 2026 15:57:36 +0100
Message-ID: <o5BaC-csTbqS-mz3dH7AGw@monjalon.net>
In-Reply-To: <20260721145841.7424-6-marat.khalili@huawei.com>
References: <20260707085048.15295-1-marat.khalili@huawei.com>
 <20260721145841.7424-1-marat.khalili@huawei.com>
 <20260721145841.7424-6-marat.khalili@huawei.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

21/07/2026 16:58, Marat Khalili:
> Public headers starting from `cmdline` (except for `cmdline.h` itself)
> and `bpf_def.h` were not previously included in the documentation build.
> 
> Add missing file patterns (globs) to include all public headers.
> 
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---
>  FILE_PATTERNS           = rte_*.h \
> -                          cmdline.h
> +                          cmdline*.h \
> +                          bpf_def.h

bpf_def.h is private now.


