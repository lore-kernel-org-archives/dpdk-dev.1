Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A8DE909B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 14:58:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E34440261;
	Tue, 17 Feb 2026 15:58:45 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id B8C51400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 15:58:44 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-48068127f00so46025015e9.3
 for <dev@dpdk.org>; Tue, 17 Feb 2026 06:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771340324;
 x=1771945124; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DAlynp+N5PItTLYiUOG3Smfz9pECaGtE09iThwGbADY=;
 b=lL+NkCQOnwdQDvvWm+C+NPsbDn5wUqUyMzycI63SuId6mptJQrhigg4iBPeKcuTNZF
 NR/AqKcXsUlkZRPn8c9ibbJMQkoeQIwvZppSL2PxiUadq2URqDb7EIdUXdkJv5Ormm+H
 kLAUdMWsim3vFrm0Zm5vuctLyZUinAtBkFmFh7LwH8YjpkEFQZ6WzBG0IxulLpWaQUeT
 PyEXsDVBzUsjGuUL8o33wAM0blPl3SWtxzppy94qLI8IkE9Y+W1HQXJ7FJzWYdgqPr01
 UIfGzT3ejiNl+ihtQXvwPo+fnPfPI+45y8v2H+zcM/GyzLl7eNaRAjeyvI306It7+4D2
 Ce5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771340324; x=1771945124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DAlynp+N5PItTLYiUOG3Smfz9pECaGtE09iThwGbADY=;
 b=fG6cS3ffQcJi6bec5JiL0YWUJedA9MYkbYPoRspe5ew6UT96SiTxv38l/jimVW6Dkz
 6k6s+VrnfH897lYf6K6rxl0QwwEL7vWZIvuhWTmAtyPSe42pl+vb35Z5jBXo5Yw84rsO
 sH2z7E4lEewzVixTn8KHbMvS+juQS2yQuCLFJe8bu0LWvCrtcY8jyUhdbMjUf0BR02Eu
 TB0RWm9p3Z/RjqPnOAcQeXd/NrVa2VJR3VDUnV81i0xyh23f2vsb/jgsrSjoEVHx38kQ
 0OU2cm8qYMZIwqpKOYVr1kl6gVkCZoAo7CDM1XxWvxVGpNvSlpEuFS9xz5B43oJF8AXh
 fXgg==
X-Gm-Message-State: AOJu0YycPrJEawArAR38jyAPaWapQcKg+tIjp5CGICLAORTgWoUuluZ4
 sI0pSuf01ak1iJhNtjgUvcF5R6G3P/bIn08+mES8xTK+US2cMa3DM/RZxAW1aUNoKtE=
X-Gm-Gg: AZuq6aJ0nHCNC+TyFHH4KYYS4yArsKFhKUnQSEERpAdOoaVGsVUUBjMQneIqDV6/ds+
 Vq50Fba2PWe9bCyEdm/wV4MQQ7zMgg8OjcHPQvdQPrvkufP/+OjkNK89CAprLNGxJKFWHHlzBcO
 nTQKA22BM2RrjAQuV751fXJUK98R1kAlpsBezDFXpbuearB47aVY18GrvaH/ASthsh4/ME7wh0q
 DnEFtBH7npxdktSj8OjLbo2OUFVoiIGW9shBLu89m2F1rGVRViuLc44jGjMZOEnZ+poNGox/rpN
 Y+R5V7BmT94V+l1+CUs0g1IdkMW9Tknnw6BCQy3v199p7ZTqH7Nz8p5bEs7UX7O5Yt2zr8fe6N+
 rMWy+ReFpI4wpoXAfsZYkHMMaeIwCXlbdk1Jfr2iJkcO3A7wtk3mYfPd92S64Be1VcA/pfudPCw
 sNqZKdtAHlhaBdw3fBkDrN63H8Hj2ckj7ACSJ3GBfRYJR0/Q/1nC9bQ5hgB0kq95j/thEAzFinD
 AY=
X-Received: by 2002:a05:600c:4f45:b0:477:9fcf:3fe3 with SMTP id
 5b1f17b1804b1-483737b7b82mr218280785e9.0.1771340323854; 
 Tue, 17 Feb 2026 06:58:43 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4837f4c46b3sm124513005e9.4.2026.02.17.06.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 06:58:43 -0800 (PST)
Date: Tue, 17 Feb 2026 06:58:39 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 0/8] net/nfb: rework to real multiport
Message-ID: <20260217065839.49e044ee@phoenix.local>
In-Reply-To: <20260217071040.2855133-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260217071040.2855133-1-spinler@cesnet.cz>
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

On Tue, 17 Feb 2026 08:10:32 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
> 
> This series implements real multiport for better user experience.
> 
> The existing driver creates one ethdev/port for one PCI device.
> As the CESNET-NDK based cards aren't capable to represent each
> Ethernet port by own PCI device, new driver implementation
> processes real port configuration from firmware/card and switches
> from rte_eth_dev_pci_generic_probe to multiple rte_eth_dev_create calls.
> 
> ---
> Depends-on: patch-37245 ("doc/nfb: update release notes for nfb driver")


Does it still depend on this patch? It looks like the release note change
is in this set.
