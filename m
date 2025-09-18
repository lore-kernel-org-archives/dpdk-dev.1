Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A550DCA1013
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 16:39:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 118584066E;
	Thu, 18 Sep 2025 18:39:07 +0200 (CEST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id 63D1D4066D
 for <dev@dpdk.org>; Thu, 18 Sep 2025 18:39:05 +0200 (CEST)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-70ba7aa131fso12445356d6.2
 for <dev@dpdk.org>; Thu, 18 Sep 2025 09:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758213545;
 x=1758818345; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5eT0BdxvOG47sW0+7/NuQU5RVItB2LYTL+bRATO7L6s=;
 b=EoEqoOjCfTwcVGJy6t5RsmQ+HTwDF/uJ5Kbx9XjJS/P69FW/hJgKbzi+rb+DQJgBMs
 SaI+WUORMuEeUCbeWQa8p5KryHpQUmIhiQK9FCP3fdkQYj2FrxVJOLmzhBTUmw3elMCn
 JDmVkiG/DnpHxcdY1Txcis8GlBnKpg8e9m31/M+PtP2yQ0GOODi5RReGVi7W1ThgHD8C
 NInWfGUk7F3BDve28wg63YqVYb6ZPWBy/g3QA1Ed0rE7m7Y6/D5KRvMQinlTd4ihlEIQ
 oAy7gdlWNd1d6gT6uLZQZS7Dur7ubxp/hxkOx1TE2NqLFitHRHR07b+n1speKELdYZ4H
 6bow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758213545; x=1758818345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5eT0BdxvOG47sW0+7/NuQU5RVItB2LYTL+bRATO7L6s=;
 b=DXqVEWqEk43JjyAD7KGp47/KmjAIbTRgqwTEl3PhRkYtgJ8d/KdpSwrl8nYD5jXHEi
 WosjSxL8+Lfi+Ng4jbRsfbncQTtMigM8VNZgXSaZF/2RoLZZGqb2UDf1yNwnvNKvyX33
 wZeyVJETJ8B++Y9ksWWX0NHrUjvctaoGuaS3DU0q/h1nVrHtuXKJtyU651NwT7sOyCPy
 flX+UdzAjfTtZAITksN60bo1+5MvQvx/gMw+QdV75rlOSPziqRSGpjqq1RxFYxUZCmM0
 W7WWb04ssubIr5LgEILRvMQ3jQYFJF5Ny00MHFDe+/cE37isL3dFmStb12CgDGmARhvi
 ydvg==
X-Gm-Message-State: AOJu0YzeXNE20X1QQTjYNdBgv/5ABSpiKLtPBJ2THOjCkCkJZNwn89bS
 MiGfhR2uDdwV2EAj+eqGmAO18haWwNMy29AkLRLGPRbn9S+ByN79QrBzof3hSAzhkcs=
X-Gm-Gg: ASbGncsrLFDJHLN4XRu7kCgowApTT+Xn9dtVLIbgCxmTvDll3UOAfvCzkWYfDi6lNmF
 U47yclYnR9BKQU+VbanV9WA6eT4PWSlhGaEUGNGknvvrg1QjiZ7JLgZ1xeIFyegvWUd6eioaMLf
 GOhxi33eHGk+MaAyq8eCt1OuJkatLdNIsNEu2KyBmcStTeEpiSHjboGmGZZDvdBJsZmJrE1EE98
 6tSJ175QEiLEjh4Ue2WLk5DuNne2/kzEDKPQqZN99iLjx0Fy9zSsIrb7lrZMUH8Ud+KIsCDV5Rv
 hvgVSY7mUqSWs90b2WOljJx1ntKFWRR2vcmXlMGTq9I6jAElMDjE56rPYMS7FrigSHHbQsF+I60
 LYJS3ZnKvxJQIs4NMOnJlfuCw5sJpr8zaWZnl5orsfJY8z1vrwF4nmH3+fhFkvrMm8OXm7FQl9W
 226CDs01qMe+x4P7+Ftg==
X-Google-Smtp-Source: AGHT+IGZuMHKj1zQ2Bye5yVNrGv2tM9Y1/HSB5abqOisn/cT0ni9ckr7kNkymj92kP7/fKDEW7Z+5g==
X-Received: by 2002:a05:6214:1c4f:b0:796:dc45:8034 with SMTP id
 6a1803df08f44-7991c5f1fa7mr707806d6.45.1758213544582; 
 Thu, 18 Sep 2025 09:39:04 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7934636f947sm15099276d6.16.2025.09.18.09.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 09:39:04 -0700 (PDT)
Date: Thu, 18 Sep 2025 09:38:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v9 04/17] net/nbl: add Channel layer definitions and
 implementation
Message-ID: <20250918093842.2f0358a2@hermes.local>
In-Reply-To: <20250917080843.646050-5-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250917080843.646050-1-dimon.zhao@nebula-matrix.com>
 <20250917080843.646050-5-dimon.zhao@nebula-matrix.com>
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

On Wed, 17 Sep 2025 01:08:30 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> +
> +static struct nbl_channel_ops chan_ops = {
> +	.send_msg			= nbl_chan_send_msg,
> +	.send_ack			= nbl_chan_send_ack,
> +	.register_msg			= nbl_chan_register_msg,
> +	.setup_queue			= nbl_chan_setup_queue,
> +	.teardown_queue			= nbl_chan_teardown_queue,
> +	.set_state			= nbl_chan_set_state,
> +	.set_queue_state		= nbl_chan_set_queue_state,
> +	.notify_interrupt		= nbl_chan_notify_interrupt,
> +};
> +

Can channel ops be const? Same for any other function pointer
only table. It helps with preventing accidental code vulnerabilities
where a buffer overrun can be used to cause other code to be run.
Therefore for safety all function tables should be const where loader
will put in read only memory.
