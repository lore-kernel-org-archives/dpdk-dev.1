Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE7710BA435
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 08:01:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A446D402C5;
	Fri, 27 Mar 2026 09:01:28 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E880440280
 for <dev@dpdk.org>; Fri, 27 Mar 2026 09:01:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774598487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1G8bmwhLVVYcFuwmSqoihjP9tGKBJoiD/7BJ+hrwLhk=;
 b=W4/CkdsngONRoSxkW9I6Emq9fX6Ls26HnbTdlI0vFFhsdLYMZP/ieGyqyTbe8b3v5EbkIq
 dQ7wTjdxfjx1bMBnpMI2Ti8HD3THUo7ZgTdktPVFvNuVa5scafgWJuGevHmpOBez8EKgMi
 EhM3X0GigKJA09Apfh6nRs6UsXkR0o0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-8t1CPgFqOzy5o8fam2BHkg-1; Fri, 27 Mar 2026 04:01:25 -0400
X-MC-Unique: 8t1CPgFqOzy5o8fam2BHkg-1
X-Mimecast-MFC-AGG-ID: 8t1CPgFqOzy5o8fam2BHkg_1774598484
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-38bda0c2e91so8712611fa.2
 for <dev@dpdk.org>; Fri, 27 Mar 2026 01:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774598484; x=1775203284;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1G8bmwhLVVYcFuwmSqoihjP9tGKBJoiD/7BJ+hrwLhk=;
 b=RHQYFOQNV5NdDnXtxlrORz7Ba8N5ZNA/hGG5fOvbUUkcvv0KZ8l4FJWKk4TiHXgxeF
 kr/vNmcH4AamCcSkILYuWsjNXysjHAPchviStccasvqJnTj5k67lKfjszL1T95VUdbqw
 uL3W/RDpOlJuoJFVWyBoc+JktrYUkOoqVRk7qmPXaXsi+vvpi+UMb8njtgET11QZSg4j
 z0j+y3XEnjfhpdRbfHLwZxv19BAWzeWx53OnfpQcWheHDdK64vOJY7CihXTlYFgbBBla
 cYQGviCvlZTDnnC84v/YNpN8ekx1KLEsdc2iAYWMtYRhDpfw23sJJ0mrGPvElUr4Ogac
 2YcA==
X-Gm-Message-State: AOJu0YyPD0guUgc+3T27r40b6njpz4cvDD0t2eKEjBtOIK9fwN0Pneyy
 UmYa9Y9UIJrn8w+LyC6sj6wdmm5gIUJKDMJJyk37Q/Nk4MrMsx0JjDSI569rzWCmjfbY5oCa1kU
 W2TQsySnsCfqZ0zwdSNhGs+Z2j9yAlwmAekeUowLnAE0WaXVbJdeLHaNEx9xDssoaLOiLsho/Xp
 0j8PFk5F5DUhXsHgY/WsA=
X-Gm-Gg: ATEYQzykOa52HE1NOEEzMMSKFUqQDICBmB/Tnpqdq7ykAUYjnNRLuqsGbf2T6mRht7Q
 CdEyKLJrmnVynXG5qmv7nNTSjhnrW3MihHJX6X/Nf1zvZd2JBZ/MV0SBwepVv3fmezfs/Lt2dsg
 Upx+jGmHQUNxJAW1pjzDvcExT7HSRxKZcXm080WmALL92SZpbmXXRcksjQL+Ok1rjEKt5YJbCJc
 EtW5smUyhydpXCH+VCFyTqttzZZuVMOWW6e6loH6r0yYjVT9kVBywf8SWC7n3iqjkpX0Q==
X-Received: by 2002:a05:651c:41cc:b0:38b:f0f0:e3a3 with SMTP id
 38308e7fff4ca-38c7308fa90mr4820431fa.5.1774598483834; 
 Fri, 27 Mar 2026 01:01:23 -0700 (PDT)
X-Received: by 2002:a05:651c:41cc:b0:38b:f0f0:e3a3 with SMTP id
 38308e7fff4ca-38c7308fa90mr4820341fa.5.1774598483276; Fri, 27 Mar 2026
 01:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260327041517.812223-1-ajp@marvell.com>
 <20260327041517.812223-2-ajp@marvell.com>
In-Reply-To: <20260327041517.812223-2-ajp@marvell.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 27 Mar 2026 09:01:11 +0100
X-Gm-Features: AQROBzC5-oE03eIHz15m1Pwy4xwXwZsD-yatVXMFgNlKQbM8Mi_kCSXhQmhVr34
Message-ID: <CAJFAV8xMNGOV9CPV4PL_TJ3PF69Zddz+D6nCZo8uMv8jqyHS4A@mail.gmail.com>
Subject: Re: [PATCH 2/2] examples/ptpclient: fix format specifier for port ID
To: Aarnav JP <ajp@marvell.com>
Cc: dev@dpdk.org, Kirill Rybalchenko <kirill.rybalchenko@intel.com>, 
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 John McNamara <john.mcnamara@intel.com>, 
 Daniel Mrzyglod <danielx.t.mrzyglod@intel.com>, jerinj@marvell.com,
 ndabilpuram@marvell.com, rbhansali@marvell.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9QC2i6A_0Sduid9KhCOh7GLnkngW0lEhtENhKUsRN_o_1774598484
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 27 Mar 2026 at 05:16, Aarnav JP <ajp@marvell.com> wrote:
>
> portid is uint16_t, use PRIu16 instead of PRIu8 to fix
> format specifier mismatch warning with GCC 15.
>
> ../examples/ptpclient/ptpclient.c: In function 'main':
> ../examples/ptpclient/ptpclient.c:797:30:
> warning: format '%hhu' expects argument of type 'unsigned char',
> but argument 3 has type 'uint16_t' [-Wformat=]
>   797 |    "Cannot init port %"PRIu8 "\n",
>       |                         ^
>
> Fixes: ab129e9065a5 ("examples/ptpclient: add minimal PTP client")

Same as previous comment, at the time this code was introduced,
port_id was a uint8_t.

This can be fixed when applying:
Fixes: 47523597ff6c ("examples: fix port id type")

> Cc: stable@dpdk.org
>
> Signed-off-by: Aarnav JP <ajp@marvell.com>
Reviewed-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

