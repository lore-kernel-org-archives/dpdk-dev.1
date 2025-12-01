Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD259D116F5
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 16:42:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D3854021F;
	Mon,  1 Dec 2025 17:42:16 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 1C4D34013F
 for <dev@dpdk.org>; Mon,  1 Dec 2025 17:42:15 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-42e2e77f519so1304559f8f.2
 for <dev@dpdk.org>; Mon, 01 Dec 2025 08:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764607335;
 x=1765212135; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BJnfrFfY9TWcVyfrzppXW3ibneoqQzopfx8AHreSfE0=;
 b=RXxDXBY4ipI+DxmD+1ut5LyQeofLNGGEqZaIBTiA+7V0tlkzhgcYNlFSqonDuHvSGd
 VzH6aNHlYNKtEWqTjJSmG1H0s+E8qgHzRJq1pjLE3pB7bvy8I8Wfjxow2t/2j2IlrJTF
 Il8Lvv3QnzMYehROVKqeX6MjtwclQGqB9IljTGJQ+As66Jg5fMa6T1FywR7rZY6K1qSk
 LhWjVnzrPZuIih+SxqPIYH/DsH3EbS2yK4iA8Tn6uNhQGP1OLF0hfP4IrpaNhPRieHl+
 /LnWSEC4eg+Md3kSbMP00CbuiZ+nQ9uc9iII41D/yJxqiVU+6bxJG4qNb5YBAGvtHIHC
 WhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764607335; x=1765212135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BJnfrFfY9TWcVyfrzppXW3ibneoqQzopfx8AHreSfE0=;
 b=lBJe/aeTItDTx2ZFXEC5GjWXi8ks4Fu9b3WQJBAGBzjbBhXCm4KyN0SLgV8tB/VPYS
 LNX8AcC0mh4VS8eR4VtZ+8K9JaN8Tk7Jvs/dVN1IB0gOeheSkKiLBye/h8KbKGGtkoBq
 fRocytZYYss8hGdUsVINy9PobDR8OoeeL7mg4tUfag0QScUPtkWdlNQQR8D0LuHOUUrV
 NcjsM5AvU4j9H57TabCW57kl2ckTlwR4VMy1nXUmvc63Naa55V090K2if6FWaGMrVfeJ
 cBCZURkiuvBLdBqUz7K6rkScEivCerto+ifNg1fbi89ntfFmRaTaNf2aVfkgNkl6LvI0
 /Vdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbHo8KNlw/OVZDHhewsPOc7tApw4zuw/KE8SZ7vNTUp40XsOcMmia0ke9izR44kKVFPwY=@dpdk.org
X-Gm-Message-State: AOJu0Yy2tqHIr0ZH8Frt6QRoWa9u2NR3o4Jny+RGA148pxNt6UB3MdPF
 mtnUHefp53xmL71ZRpmNlAHJgDj77GfMyiauaJh54Wh5V9XmXzxr19/NtIwjAHbxdsPNfGw08dr
 q6Gwl
X-Gm-Gg: ASbGncvo/zWb6sF/qN/vZ4IxMS2QRcIx2mk1GkMbiimMdRuxqbn72Jwgc4lcQ/6aBUQ
 tMa6Lgtpo3Pq0xKWFE2xNlMVx1WXQqulVXovsfT7dJ2Y5I8IfKT/9GQ4tEtPwWCZmXKfXaYEkEj
 S4BYvQSr4RJ92dlkYTfD3qqosZjkEI91gLT7cwFlmP99hbMAv/TkpC3igkOZtmSSx2i95+U26oC
 RUCKIy//N8b/a89fXQsfeSViXonpB+aTqKukG4Yn7iKPTaZbfxWFrufdyJM434SC7E1L3aBrznP
 Vi8HbWYhzxUr3AGFPLchVQApLeO+aJL1IOt2UMp1LcPPqga6JMeQev4I/Ea3xLp9L0Jg67TP7mK
 kERMRy9Fz+FuZDanBYTxCYZ1MB5dkx8w4Mv1omVbk6fDryoqyjEopRAooDsDOaB5e6rVGzBn0Zb
 TWsjFSYkU6XUq7DcJAsmCWeEvZesSkEtxnGA+r9gt4vghLQ3ufklWk
X-Google-Smtp-Source: AGHT+IEvd2Vu24hPfsOhTSlbRxlQtP/i+nkciGnfw/5eQYE2+70C7QHYYVOuJoVEggzzApdPQHUgjQ==
X-Received: by 2002:a05:6000:2088:b0:42b:4951:8af3 with SMTP id
 ffacd0b85a97d-42e0f35679fmr27524763f8f.43.1764607334530; 
 Mon, 01 Dec 2025 08:42:14 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a38bsm27772418f8f.24.2025.12.01.08.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 08:42:14 -0800 (PST)
Date: Mon, 1 Dec 2025 08:42:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "=?UTF-8?B?bWFubnl3YW5n?=(=?UTF-8?B?546L5rC45bOw?=)"
 <mannywang@tencent.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
Subject: Re: [PATCH v4] acl: support custom memory allocators in rte_acl_build
Message-ID: <20251201084209.1439eccf@phoenix.local>
In-Reply-To: <F28176920A8AE2E0+20251201120508.120236-1-mannywang@tencent.com>
References: <db4d85aea29e4549b04750288db649c3@huawei.com>
 <F28176920A8AE2E0+20251201120508.120236-1-mannywang@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Mon,  1 Dec 2025 12:05:07 +0000
"mannywang(=E7=8E=8B=E6=B0=B8=E5=B3=B0)" <mannywang@tencent.com> wrote:

> +static void *running_alloc(void *udata, char *name, size_t size,
> +	size_t align, int32_t socket_id)
> +{
> +	(void)align;
> +	(void)name;
> +	(void)socket_id;

Please use __rte_unused attribute or RTE_SET_USED() macro for this.
