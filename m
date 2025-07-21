Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3F1C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 15:35:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6657440689;
	Mon, 21 Jul 2025 17:35:04 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id AEAB340689
 for <dev@dpdk.org>; Mon, 21 Jul 2025 17:35:02 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-7e346ab53d8so395689185a.0
 for <dev@dpdk.org>; Mon, 21 Jul 2025 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753112102;
 x=1753716902; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T2ncp4yebND8RrSUmSLWOmPcoVCvYw0wscM29ZWTbXU=;
 b=KUFdufFN+R2IrxoIrS03aiMXo8YiV7yULxTXYEsYDwqpew+XHS3wvcYF9W/aQSUYJf
 UKjEX5NzwHqGoeZTSX2ap5MmdZe7cIcCG9iDb597LWttzVr/l4/5fmdQWZYltnHLOn6B
 XetdTFrkQRP+G/d3d/EP2UtbN6sTxv3fWfGWpKizwfop2/zjNmqZH/wbu64sc1t4LzAT
 IWXRbWRvWPxhCS52UzJjXupEybfo2r+z04YUmFV0odp5BuCiQNcPIUcJ7lDIczzv1vod
 3iCetbBc3hJurQwYiEMv5nFElZ5DmZb+K4jadRFCsSXicQ+j6+RDDHNMtaoD1FGf/dGb
 Gxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753112102; x=1753716902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T2ncp4yebND8RrSUmSLWOmPcoVCvYw0wscM29ZWTbXU=;
 b=cscCByXqiav6MTWGhxXrmAhdC0hMGY5C5O61OKfHvF5zckngBN8gN/YQv+DizYUziz
 Ld5xOZYHuEu2/ZmypCz/W7W3xdVRDje/w3Pvj2pQEDrR82A4dHH15iUhzw5OXv+EUy2L
 RnVQTQAE2wiQinY/o+HCl7INEWIUrYbfq9v3Mgj1fxNtMp/Cw+zpyB7UlcAr5wtIZYy9
 5pzSV2zgZobmN578LpzgbuirIP+1mLWQzFUwsUaiYUFQVBMWZ9tKoyjOvq+j8kk9PhQH
 XbHAPjk++n7NGVXl5U9K1Sfnjuo7XHNeG0S+RoIkPS9V8h2xkiRXSDuDU/URBDf422xl
 a6Dw==
X-Gm-Message-State: AOJu0Yxo3nFOJrVYCeaxbduSIIu2Cnn1tpmhCPnN1dVkhicPUqXlhFZ1
 JDBrbbqUsMxg1H/VC4QGIj8kB7fM/v3CGRwa6Yp/7DQMTLxfSPkOgSilrcVgaIxRd+s=
X-Gm-Gg: ASbGnctQDhF8MqOmeOvcI3Od0fVMJmM9Crz5dLcC9NgXys20a0GsobcrUQU0JJeFQAt
 FCjyjATAOLQGTtdgiHOypbGPkA7JQPM7M1T5DaVRGxcE6H1Wmkl864rnxhT5QqXTjqQCCGLxnyN
 qPlX+iH8rPgwk04aofPTeAEy3GidXgYSF3on6DasG97hWB42+t56T7i74J0LeD6U3z/Yckp2Vck
 gQpFyAO/ZZ7h/ANCzKMENTTDc31MSNQ8MDASgPLfn1GbzeZ4L+t2HXoJUwAIRsTVsO2EsVqD7F9
 tuk0VvDVQkoVd99B3kr6m0u8Fg/1a7Grerb+bvy84003XTlmw4Fko1SLZkBaA3wJaFQbbUuSXAT
 xQlUSUgUK+/gdDRG5B7xdZEtpPznJMTSkskkcHzkSA//r8jUFwgzl/XGqblqmBWPlpjPbrLcuQ+
 s=
X-Google-Smtp-Source: AGHT+IEzjH9MYEBFpJl9y8q1geNK8ObUJm6b0xLhGKsOZpg0TlSiqfAtwSSx7JprNC+KrQlJ2GIVJA==
X-Received: by 2002:ae9:e304:0:b0:7e3:2c2c:4ce6 with SMTP id
 af79cd13be357-7e34d9abf75mr1587227785a.38.1753112101843; 
 Mon, 21 Jul 2025 08:35:01 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356b2854asm425216885a.18.2025.07.21.08.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 08:35:01 -0700 (PDT)
Date: Mon, 21 Jul 2025 08:27:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 02/14] net/sxe: add ethdev probe and remove
Message-ID: <20250721082717.430b1f6c@hermes.local>
In-Reply-To: <20250719090537.699357-2-liujie5@linkdatatechnology.com>
References: <20250716082930.83026-14-liujie5@linkdatatechnology.com>
 <20250719090537.699357-1-liujie5@linkdatatechnology.com>
 <20250719090537.699357-2-liujie5@linkdatatechnology.com>
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

On Sat, 19 Jul 2025 17:05:25 +0800
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> +
> +#ifndef fallthrough
> +# define fallthrough do {} while (0)
> +#endif
> +

This won't do what is expected. Compilers will complain
that switch statement has unexpected fall through.
Either make it an attribute or use comment instead.
