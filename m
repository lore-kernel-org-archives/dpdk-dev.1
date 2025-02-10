Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC7FC02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 18:24:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2658E4064C;
	Mon, 10 Feb 2025 19:24:18 +0100 (CET)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id D975E402E5
 for <dev@dpdk.org>; Mon, 10 Feb 2025 19:24:16 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2f441791e40so6485503a91.3
 for <dev@dpdk.org>; Mon, 10 Feb 2025 10:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739211856;
 x=1739816656; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=unYzLJFEQlqKsy6vJgrjzbVVoYnSw0UPTBndx72ziTQ=;
 b=I1Dli0Hx59KPjZctoZ+RpOhPps/ffjEIV9fa1Muls0/pSczqw5sn3jOIz0LLP6TNUA
 /UdRpULVfOdVymDtVbtv6HflWnhvWxEJ9AT0km/cDeu6c2YIO4vRyGy8Oy31wgZUNbG8
 7XCroX9Ywa7bGtv6ai0KZkp0X/Ouw6zCT5kg5yzfImgOrzYzEJAnyfOjHNOaar7HPTWN
 vQZxcbl1aovq9x1WT59MSMgnHKYrYWrRy/dZ03LDpgwUDKmbY/ZmAHs8smy+/Pv/yoQp
 CImDFXQPK1gfv9TMTWUI23urrQYhCNfy9KtprE52GSnQaRrxfcRg6RJBU3Yinesv6rEt
 VlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739211856; x=1739816656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=unYzLJFEQlqKsy6vJgrjzbVVoYnSw0UPTBndx72ziTQ=;
 b=KvDbY0drBs4KdtUYn2QcO5Zfb9bSFbG+24CznACxs0axg+suUm/ODnTBDPaeKO4LgR
 u1NowQnxAFMI9eg7Hg9fXaILk8lppozxQW4tepsoUHV4TqXInceYFM8W4wV8Ik7mktDy
 DBEpmbA84afNak61UiAhR1kmRS6dFeyGU/Z72ZaPpPa0oOznUb5gys7kMEGqAgXVb4fn
 8uCvRMMfz7PSerJaujm5fN9NfvW0QzaeRVA5Zlc0d0t15YfVipdqke69tUzxB59JhieQ
 RIr4b3HgQR66VUIgG0HUFVUppIAKqx2quuFm7j8E0HmfcVMtTeaqXXBeUTue0V1kcTvc
 822Q==
X-Gm-Message-State: AOJu0YxxpJj+TEPiv8HiAGGXk7l7kc1k7oB6hXGICDv6uRLwPnoXFr/6
 O6Ng44BMqi24dl8DvTzg8K8ENXK8mbS05du+7huPEd5oCF/oc5eo/zgwFc4rJITJC78G8qTwdUG
 t
X-Gm-Gg: ASbGncsJlNZgu9xV+AkgKIFljW1/wQP/pEflZM39zXVQwYGoZ7wFoDKhnF6T/g5O5aZ
 Ejuf5bv98+M8amuMIYALqCp5AEVCUU2jXRawgzuLwPdlYQZF316eHWS8gL0Lhwpl2OlFWRU1Kwo
 TfwXIGRtia13PimChPDa6apZUVQdXvLG/4dQgQIrvINN9LL190q81WzgwCqdm14wqAhVDnorar8
 Cv+r8kEdmCcgyDOYLCIIBAJeE31ej3asrtJyn7wSzNqzFYwAvmM/Xyh4I6SSRgC4hxTLpdpsiVL
 ZT/Dt9DdIbkRXMEMayxnH2leAVtxQ1sl6Kx20izZpxrPcEP+YOny3uY9XM0zTYinVo/Y
X-Google-Smtp-Source: AGHT+IHhuE6rKns4KQwzNvo075sWrekyuLVSxaADbW3heuo8ODonPc37cIGN5u5VgmVo03mo5gnnXQ==
X-Received: by 2002:a17:90b:4d0c:b0:2f1:4715:5987 with SMTP id
 98e67ed59e1d1-2fa240642f5mr23272173a91.9.1739211855994; 
 Mon, 10 Feb 2025 10:24:15 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa42dde5e5sm5519217a91.3.2025.02.10.10.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 10:24:15 -0800 (PST)
Date: Mon, 10 Feb 2025 09:25:24 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 02/14] net/zxdh: support compatibility check
Message-ID: <20250210092524.202049f1@hermes.local>
In-Reply-To: <20250210014645.4105437-1-chen.bingbin@zte.com.cn>
References: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
 <20250210014645.4105437-1-chen.bingbin@zte.com.cn>
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

On Mon, 10 Feb 2025 09:46:45 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> +
> +static void
> +zxdh_np_fw_version_data_read(uint64_t compatible_base_addr,
> +			ZXDH_VERSION_COMPATIBLE_REG_T *p_fw_version_data, uint32_t module_id)
> +{
> +	void *fw_addr = NULL;
> +	uint64_t module_compatible_addr = 0;

Why do you initialize variables then set then in the next statement.
Sure the compiler will optimize away the waste, but not good style.

> +
> +	module_compatible_addr = compatible_base_addr +
> +		sizeof(ZXDH_VERSION_COMPATIBLE_REG_T) * (module_id - 1);
> +
> +	fw_addr = (void *)module_compatible_addr;

You could skip the temporary variable here and just put cast in the memcpy.

> +
> +	rte_memcpy(p_fw_version_data, fw_addr, sizeof(ZXDH_VERSION_COMPATIBLE_REG_T));
> +}

We want to get rid of rte_memcpy(), only use it where it is performance sensitive
and variable size.
