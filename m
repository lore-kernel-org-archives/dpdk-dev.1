Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BBCFD8FFA
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 18:44:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B007F4028F;
	Thu, 26 Feb 2026 19:44:39 +0100 (CET)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id 252C84027F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 19:44:38 +0100 (CET)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-8c70b5594f4so115254585a.1
 for <dev@dpdk.org>; Thu, 26 Feb 2026 10:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772131477;
 x=1772736277; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZSsb7lGZ1+DMXtemFCduQseZotZSKzfNzl1dgKWL+Ig=;
 b=NeNIeu8PlZn+szDWq2rHq6wvdIaWuH1gKJLxyhCxuoUYlxGp94/5s2TjZlmVyK2dDa
 2GwnixbYZomUlFbwWEFGF9JX4tMffvC/0827YKv6BAC2X2ijPcd7+eOYBtnxld7EzD/r
 L89bzBqzIAE8cc+6fq2Gm7fKmewF8PvIvo12OceX8+zhyrvr+y0rWF18/U+tCH7oG3kB
 hx3m71x90nrop7gK/Bm9FsKpb6z/GVb20jftZK7bFjM9jJAEyZ9UFrV7bb1RPNDn0h/L
 Jggq1l6lLo+shQrSIKm5ov5jxCkQQJQfimU3k7TsUWiJxY1Gk+Rre+QNuW8hYRBPSNyK
 FmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772131477; x=1772736277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZSsb7lGZ1+DMXtemFCduQseZotZSKzfNzl1dgKWL+Ig=;
 b=peShHgVfM9QzkX/90eMkF5xl18mRLMh5rpG3AsNTOaLyR4B5s2iXZcjE/WEg1HiM6Q
 1hp63Ig63VtXkr8qfcFIz4pWR0e2mnyZg+7xNo6zn5ZUDp3Tf3LYUhIgdhB/zjpIPWB3
 Wt8LvjosFhyoSAy8XnL0P0n2zOWlirB3XUragSbXUby2MPrXj5HoySwe0kwKqCPrRPaW
 CEJPb5SlfkpswvP5+V1Gep67qMq8k2OnjUpzBQTap0V99p2ZxIvqJbwHrGm1r1JiNiOf
 sFwjc4Rz89a/hzWBVV1ra7MRQN2kWf7pfX8aKAyThLuBglu8APdpDgpF1pYJXS2lvBh+
 Qalg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg55RvRaK+ID91NQjbXuN74+VQTZNPwYPJfQNMUvxVlBSjT/qOaGbkGtlQDZONjE7EEls=@dpdk.org
X-Gm-Message-State: AOJu0YzaKv3pWZESHGo6bdsJiaPilBTq7WvVQoKE3jpxiYNgwbR9jHg4
 Z7LP45uO6+BqEcCwL1pS6HILqh/5KO66I3R+Bb7Mbc0RVBc90yhv438jaR6aHoIwNqY=
X-Gm-Gg: ATEYQzwWEW52iX9KBzKjCHuwdnmifKb9iqYy3d+95D8ivJ2qPg/vX4Bz4h402S6FITY
 QmsI6JHBaiyQwiApXQaeK55tGOO60WreP3LysIOKA2biUtfwT+BZ/5ZLSQWrnq1BD7bCHnYX5Vo
 h6B/FZh7cnFGu+G79AOqycNJkRCvpxCTHXDIk+XlSz8Tk0eP3XMOVikLtZuM8sMbq4B23TQQE5N
 eadcwWJNKDW6V5DUFKP9ZDY7FDTZE6C+TN9JhMc5FhK+25kGpm5aex+6syVDXwQV00ahjMRggw0
 yLn/Fey5UT4Zl5shufM9eJSIrqGOeA14nL6mowhJficO1oWSgmxahUgstdHszC1DKs3LN6kc1x8
 vsHGxpG2hShxsPW7jjJx/AP7U60hJIGJWmwnINAR03Bbc+H7JTxsaTvcd7ewXmMrKed2CtbEEt9
 LyUPfOVG65H9Xc/tLJodTU6Fm2Qdm/snYyIBEUvmPjBKoO9SHvrDza7J+dcx0Twlft
X-Received: by 2002:a05:620a:1a90:b0:8cb:55d3:2a0 with SMTP id
 af79cd13be357-8cbc8c6e8bcmr7816785a.16.1772131477278; 
 Thu, 26 Feb 2026 10:44:37 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf6f93b5sm257925985a.31.2026.02.26.10.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 10:44:37 -0800 (PST)
Date: Thu, 26 Feb 2026 10:44:33 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: P1erreCashon <2022302111412@whu.edu.cn>
Cc: Stanislaw Kardach <stanislaw.kardach@gmail.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Yipeng Wang <yipeng1.wang@intel.com>, Sameh
 Gobriel <sameh.gobriel@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, dev@dpdk.org, gong-flying
 <gongxiaofei24@iscas.ac.cn>
Subject: Re: [PATCH] hash: add riscv vector support for 16-byte key comparison
Message-ID: <20260226104433.0c2dcbc2@phoenix.local>
In-Reply-To: <20260226064939.2362323-1-2022302111412@whu.edu.cn>
References: <20260226064939.2362323-1-2022302111412@whu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 26 Feb 2026 14:49:38 +0800
P1erreCashon <2022302111412@whu.edu.cn> wrote:

> +/* Functions to compare multiple of 16 byte keys (up to 128 bytes) */
> +static inline int
> +rte_hash_k16_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
> +{
> +	const uint8_t *p1 = (const uint8_t *)key1;
> +	const uint8_t *p2 = (const uint8_t *)key2;
> +	size_t offset = 0;
> +
> +	while (offset < 16) {
> +		size_t vl = __riscv_vsetvl_e8m1(16 - offset);
> +
> +		vuint8m1_t v1 = __riscv_vle8_v_u8m1(p1 + offset, vl);
> +		vuint8m1_t v2 = __riscv_vle8_v_u8m1(p2 + offset, vl);
> +
> +		/* find != bytes */
> +		vbool8_t neq = __riscv_vmsne_vv_u8m1_b8(v1, v2, vl);
> +
> +		/* if any byte mismatches, return not equal */
> +		if (__riscv_vfirst_m_b8(neq, vl) >= 0)
> +			return 1;
> +
> +		offset += vl;
> +	}
> +
> +	/* all bytes equal */
> +	return 0;
> +}
> +

Compiling this with godbolt generates much bigger code than simple 64 bit version.
Is it really faster?


int
rte_hash_k16_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
{
	const unaligned_uint64_t *k1 = key1;
	const unaligned_uint64_t *k2 = key2;

	return !!((k1[0] ^ k2[0]) | (k1[1] ^ k2[1]));
}


rte_hash_k16_cmp_eq:
        ld      a4,8(a0)
        ld      a5,0(a0)
        ld      a2,0(a1)
        ld      a3,8(a1)
        xor     a0,a5,a2
        xor     a4,a4,a3
        or      a0,a0,a4
        snez    a0,a0
        ret
ricsv_hash_k16_cmp_eq:
        li      a4,0
        li      a6,16
        li      a7,15
.L5:
        sub     a5,a6,a4
        vsetvli a5,a5,e8,m1,ta,ma
        add     a2,a0,a4
        add     a3,a1,a4
        vle8.v  v1,0(a2)
        vle8.v  v2,0(a3)
        add     a4,a4,a5
        vmsne.vv        v1,v1,v2
        vfirst.m        a5,v1
        bge     a5,zero,.L6
        bleu    a4,a7,.L5
        li      a0,0
        ret
.L6:
        li      a0,1
        ret
