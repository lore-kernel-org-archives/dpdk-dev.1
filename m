Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97D360A2602
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=Pn0epZFb
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63E9140E6E;
	Tue, 10 Nov 2026 16:08:19 +0100 (CET)
Received: from forward504d.mail.yandex.net (forward504d.mail.yandex.net
 [31.44.14.20]) by mails.dpdk.org (Postfix) with ESMTPS id 05D8240281;
 Tue, 10 Nov 2026 16:08:18 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-80
 (mail-nwsmtp-smtp-production-main-80.yp-c.yandex.net)
 by forward504d.mail.yandex.net (postfix) with ESMTPS id A5C951003C2;
 Tue, 10 Nov 2026 18:08:15 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80 with ESMTPSA id
 A8UA8EE3g4Y0-ZCytQp7w; Tue, 10 Nov 2026 18:08:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1794323295; bh=fvVL4ApI5BUfJiTWkDp5D6laAiq45imftaUnH2yhuIY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Pn0epZFbcQD3qFCGaOjhPTHGNn9VeKyD2CxpAj21UE+pWErMO73hMFEX+MNbmwrgg
 Svl00A7OfBdQPdCm5Hc7i5KVWtWx7iWDVn2KFc3mOBOUE9wzUBFtfPMe/1fcF701PE
 K512bxaNbld8na0VDwD2XOY1sFtd4jfRgaRyjg0Q=
Authentication-Results: mail-nwsmtp-smtp-production-main-80;
 dkim=pass header.i=@yandex.ru
Message-ID: <243ec0f2-f8fc-4074-b30c-4e9b5fcd94ff@yandex.ru>
Date: Tue, 10 Nov 2026 15:08:10 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: fix index register for classic BPF indirect loads
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: stable@dpdk.org, Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>, Ray Kinsella <mdr@ashroe.eu>
References: <20261027170619.2193021-1-stephen@networkplumber.org>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <20261027170619.2193021-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


> Classic BPF filters using a variable offset into the packet, such as
> "tcp[tcpflags] & tcp-syn != 0" or "tcp[0:4] = ...", read the wrong bytes.
>
> The indirect loads ldb/ld [x + k] were handled in the same case as the
> arithmetic instructions, which take the source register from
> BPF_SRC(code), that is bit 0x08. In a load opcode that bit is part of
> the size field, not a K/X selector, so BPF_LD|BPF_IND|BPF_B (0x50) and
> BPF_LD|BPF_IND|BPF_W (0x40) both yield BPF_K and the index register
> becomes R0 (A) instead of R7 (X). The halfword form works only because
> BPF_H and BPF_X are both 0x08.
>
> Give the indirect loads their own case next to the absolute loads and
> emit X as the index register. The interpreter and the JITs already
> take the index from src_reg, so this fixes all engines.
>
> Bugzilla ID: 2085
> Fixes: 2eccf6afbea9 ("bpf: add function to convert classic BPF to DPDK BPF")
> Cc: stable@dpdk.org
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   lib/bpf/bpf_convert.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/lib/bpf/bpf_convert.c b/lib/bpf/bpf_convert.c
> index 37095eea52..a32e1cdd8a 100644
> --- a/lib/bpf/bpf_convert.c
> +++ b/lib/bpf/bpf_convert.c
> @@ -301,6 +301,13 @@ static int bpf_convert_filter(const struct bpf_insn *prog, size_t len,
>   			*insn = BPF_RAW_INSN(fp->code, 0, 0, 0, fp->k);
>   			break;
>   
> +			/* Indirect loads index the packet with X: A = P[X + k] */
> +		case BPF_LD | BPF_IND | BPF_W:
> +		case BPF_LD | BPF_IND | BPF_H:
> +		case BPF_LD | BPF_IND | BPF_B:
> +			*insn = BPF_RAW_INSN(fp->code, 0, BPF_REG_X, 0, fp->k);
> +			break;
> +
>   		case BPF_ALU | BPF_DIV | BPF_X:
>   		case BPF_ALU | BPF_MOD | BPF_X:
>   			/* For cBPF, don't cause floating point exception */
> @@ -328,9 +335,6 @@ static int bpf_convert_filter(const struct bpf_insn *prog, size_t len,
>   		case BPF_ALU | BPF_DIV | BPF_K:
>   		case BPF_ALU | BPF_MOD | BPF_K:
>   		case BPF_ALU | BPF_NEG:
> -		case BPF_LD | BPF_IND | BPF_W:
> -		case BPF_LD | BPF_IND | BPF_H:
> -		case BPF_LD | BPF_IND | BPF_B:
>   			/* All arithmetic insns map as-is. */
>   			insn->code = fp->code;
>   			insn->dst_reg = BPF_REG_A;

LGTM, one note:
As Marat already mentioned, can we have a new test-case for it?

Acked-by: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>

