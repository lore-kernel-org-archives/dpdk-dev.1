Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269EAC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 May 2025 06:44:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13AA8402AC;
	Mon, 19 May 2025 08:44:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E5F8E40276
 for <dev@dpdk.org>; Mon, 19 May 2025 08:44:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747637076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ClTFRXss62h1BR8tuX7CB4iK0Q6kEFAL/WQrww0bPqw=;
 b=Z1eICGtGicPI4YSy0Dpzypvyw2ZcaP2qKN+L5fO4jGeXhTKYMO9KojGZQ7MkBInnPkkBkx
 0ldrm+5wRyH4vvxCLKJCjeEUN8HKFJfwcTV9PppXvllhredslhusTPE+8vqRQegn2MoLCF
 mrG+vtm4DlrvGh+rcbECbt4+HSv2StQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-VEV31Ms6PfWm8inR5IChvw-1; Mon, 19 May 2025 02:44:34 -0400
X-MC-Unique: VEV31Ms6PfWm8inR5IChvw-1
X-Mimecast-MFC-AGG-ID: VEV31Ms6PfWm8inR5IChvw_1747637073
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-550ea89a8b0so1064940e87.0
 for <dev@dpdk.org>; Sun, 18 May 2025 23:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747637073; x=1748241873;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ClTFRXss62h1BR8tuX7CB4iK0Q6kEFAL/WQrww0bPqw=;
 b=KK//l6bfbM+t9sKCu1cuBm7hQku6EQ/Ea1iAFFr69shIqRgI+Sgqs4Kk0LcbX1kVgt
 laeFWpScxgSa9vs06uewKkf3NF4t9PIQQzWkhrLaMvcrKGHu2IIDblHJuq6xoW7clwqQ
 CMPJlPI6ED7qrTLvxu5uU7Ko5IvsKy/dZr9CuRLsSeDecU8/MqBFivmMfPVUiWvw4DKz
 zC6Y/tzbfffk+vf9a2e5pd0jy7vtiNZAWsQ8PaOdcCmYhFAIFQQaJiXpHDHSgSuOFRf9
 lNEoKbxbfo9hJ0bdEuYa+q9x8v5ECBDMbbBe7calYWbzR9bkGvMprxjDYmzkbhQKr33t
 RsQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJmDZniFBraT69+rHqA3hpO7VzKzpGrGN6CeERYIddxOUaE4kaDlvwxgbpNnqlYP9b1Zw=@dpdk.org
X-Gm-Message-State: AOJu0Yykek0VNM1GWqXNOJC8U9XVOxTVvcsF/RqfTUvD5kII0f7LAdUd
 SmSk7FLEzGWy8V5QgUMRLCdi3vMRcAhmf1GOXBfqG/xSFFEbzdwsqfh+ZsIN/vcAfWHj2lVJL5M
 5qny6Nkd+7kCz8uRS9Fzw5IZSXJ4nOfxQcjj6R0rYj+EjvDl3F/ynkCPlDCTul5r09iWL3xMKiK
 LPjQV4xR7mo5CYTjs3hig=
X-Gm-Gg: ASbGncuCe8LCVhAewYiMFrlPyqBSCR/dN3uHkvyuVXtsxs4AS4pXSO6QJIrMsYfD8qa
 6x/DyurLdPQVqSxXxh4YnmTJSij6p9/9elnfbkLAAp0+RepNkf1rQDtYM8eAFk02w033TEqA=
X-Received: by 2002:a05:6512:4019:b0:54e:a2f8:73d7 with SMTP id
 2adb3069b0e04-550e98db6b5mr2911791e87.31.1747637073054; 
 Sun, 18 May 2025 23:44:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4qqrbVS3jieB/adWUQ6hRWs2TDWlwvhmX+Ob7oInwyjlpKK4vmEQzvPIPGiXm953IGqLPECskT6xpaQnXPSs=
X-Received: by 2002:a05:6512:4019:b0:54e:a2f8:73d7 with SMTP id
 2adb3069b0e04-550e98db6b5mr2911786e87.31.1747637072683; Sun, 18 May 2025
 23:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250517151736.2565461-1-wathsala.vithanage@arm.com>
 <20250517151736.2565461-3-wathsala.vithanage@arm.com>
In-Reply-To: <20250517151736.2565461-3-wathsala.vithanage@arm.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 19 May 2025 08:44:21 +0200
X-Gm-Features: AX0GCFvNZUOOaVBNH5Ar9pdxdrcbim7qqJF9yehdGGaLOL_-hcIIAlPLdwkgtSo
Message-ID: <CAJFAV8zzDOqg7ENee+V=HxG2e3ZGtXmcX8CES3SD_oufsKy8mA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/3] bus/pci: introduce the PCIe TLP Processing
 Hints API
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, 
 Anatoly Burakov <anatoly.burakov@intel.com>, dev@dpdk.org, 
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Dhruv Tripathi <dhruv.tripathi@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xQvY3199tQPOYRyigzywUZg4ZrL8txY5G5U6xrptiow_1747637073
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Sat, May 17, 2025 at 5:18=E2=80=AFPM Wathsala Vithanage
<wathsala.vithanage@arm.com> wrote:
> diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
> index c20d159218..463c06ad64 100644
> --- a/drivers/bus/pci/linux/pci.c
> +++ b/drivers/bus/pci/linux/pci.c
> @@ -814,3 +814,97 @@ rte_pci_ioport_unmap(struct rte_pci_ioport *p)
>
>         return ret;
>  }
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_enable, 25.03)

The release currently prepared is 25.07.
(no need for a respin for just this comment, this series is not ready
for merge in any case)


--=20
David Marchand

