Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72862E81A44
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 16:55:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA0CF402C5;
	Mon, 16 Feb 2026 17:55:22 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6806A40289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 17:55:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771260920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MmbiNE3OpgipsZzQEmooaTRXa59ZbNajLVllg2zt3bo=;
 b=Amq0kE8HD5UatPWpEHEvBxg9BZlmj+KQwOcRhEge0TVD8WDi2cgEiOV8Ib/V4/4rIv5HWp
 egAyalWHhKuG/U1NoLEwv0quGGsyqkeGCOSnHHHBzOC7kIcgMctp3iWGcid34Fa2X/1Wjl
 pDcS/NpIPFqp/4jecQ3KQ7MlYj3RWfk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-c-XTk1odOVyP_O6aZgEpsA-1; Mon, 16 Feb 2026 11:55:19 -0500
X-MC-Unique: c-XTk1odOVyP_O6aZgEpsA-1
X-Mimecast-MFC-AGG-ID: c-XTk1odOVyP_O6aZgEpsA_1771260918
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-435ab907109so2281931f8f.3
 for <dev@dpdk.org>; Mon, 16 Feb 2026 08:55:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260918; x=1771865718;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MmbiNE3OpgipsZzQEmooaTRXa59ZbNajLVllg2zt3bo=;
 b=gOVsDcfUwIX5cEdUK4w3Hkbi9tznxOlYTmx3e0Bn3HGLBmrs31VEK2GjVegDwd7+eU
 NeO32NlUwZZkCfQdIqtK4XV/l5k16AHe++CSSEqYFKQ3tuM95jxQM2Ww2v5orOlpysMH
 tYlsrqfF/Grayf/XTQjbWPte7KjvWMbvVMEHI7oPPh36eGLZWRl3CBZtdDnL+kfnUxe+
 tBhH46wyYChISkXkuWbGQWGcA4X70+raA3f4RpjmXv7b4B0obkssz/yVrc7xmGbpFz+7
 UNKlD0wR7YUMHoYIPJjrACsEN9Xw0Cy2hOJg571bBIvIpXkkI5sfib9IhoJx6wuYdnQP
 keZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtyLUa5YTWq+izTvkYCKjr14524MpdL4rS66lIQi5F3cMyK7KPuXwXynSgL1F0xM4siS4=@dpdk.org
X-Gm-Message-State: AOJu0Ywa6EdqGS3go3n2sLCbOOvw270xT3ndhMtlS0yza/gq/T1lJ6FT
 5OddyyEyIFhE8F573gFn44AmpR11TT/TQsXp1LpyX8nvgnmwIz8BEkx31VR+Xng0uKhUzXKd4wZ
 rR1/Q6bUrej0eVH8qmJHDDzDYiFYq1q6oAc9LSdx6BVW+
X-Gm-Gg: AZuq6aLyrT/xJ8/scf+5dqatA19gQDw2cPiCbd9ZrWSnqJycdJ8FpzO7UTkpvAlQQ4i
 cc7jA5wIckJxW0OhfKc/rgx90d/D4G1ADBSXJ53v9XTQvYnfTB2I0pCbrZ7FAnykfZHv3Pb62f2
 qWXmZxHNt6WXYQcc9wAGamN+tyL1n2Z0PwiCS8CXxYwz9UACGrJtLjC211QoPJVvZ3fEMpTVsOy
 zwnUGBNuUQcvMX1f3d5mEZlfMzbgIT4jS5QSUuGFEZeMjfuvLroXnVOdTtc6/50VWpqnH3KLhnD
 AFMW6XfCAF0+HHA1HJPubql2E3gfRQZis314sW4bFOJiTbJeLbv5WVADIFYQdS+hrH6eR0ZrfUi
 UNic9HdCdXlOg1tl2itVJKBdeik9GzZpUA4GKjgFM2+ysrIvGSG9gTfpwTskRMU2kyAs3DODNTB
 QC1Io=
X-Received: by 2002:a05:6000:186b:b0:437:895d:2026 with SMTP id
 ffacd0b85a97d-4379790e995mr24545914f8f.38.1771260918128; 
 Mon, 16 Feb 2026 08:55:18 -0800 (PST)
X-Received: by 2002:a05:6000:186b:b0:437:895d:2026 with SMTP id
 ffacd0b85a97d-4379790e995mr24545853f8f.38.1771260917652; 
 Mon, 16 Feb 2026 08:55:17 -0800 (PST)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d46sm28764479f8f.32.2026.02.16.08.55.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Feb 2026 08:55:17 -0800 (PST)
Mime-Version: 1.0
Date: Mon, 16 Feb 2026 17:55:16 +0100
Message-Id: <DGGJLBN5WD6A.2P8GRP6IARGRA@redhat.com>
Subject: Re: [PATCH dpdk 1/2] graph: always count objects and calls
Cc: =?utf-8?q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, "Jerin Jacob"
 <jerinjacobk@gmail.com>, <dev@dpdk.org>, "Jerin Jacob"
 <jerinj@marvell.com>, "Kiran Kumar K" <kirankumark@marvell.com>, "Nithin
 Dabilpuram" <ndabilpuram@marvell.com>, "Zhirun Yan" <yanzhirun_163@163.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: "David Marchand" <david.marchand@redhat.com>
User-Agent: aerc/0.21.0-98-g3a0874577a2a
References: <20251209085028.115203-4-rjarry@redhat.com>
 <20251209085028.115203-5-rjarry@redhat.com>
 <CALBAE1OMwTX=a5i56G_sPXicw=17ozvb4PBfak0ev2Ps3xwuGw@mail.gmail.com>
 <DETKJKSUL9XG.1CTKW09I3UWSB@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655C8@smartserver.smartshare.dk>
 <DETNTVDMT8U6.307XVRW7VTBIE@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655CA@smartserver.smartshare.dk>
 <DETP2Q0QF39V.1KWT5Y2P9RLD4@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655CB@smartserver.smartshare.dk>
 <DETRNKI1EOKX.1GQT599JGQR7E@redhat.com>
 <CAJFAV8x+td-T3LswKBoN6+vC1aYXAaJVZJZvRYtwkTHCwi=gaQ@mail.gmail.com>
In-Reply-To: <CAJFAV8x+td-T3LswKBoN6+vC1aYXAaJVZJZvRYtwkTHCwi=gaQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Qz_4nd3rKIoMAsFsMeiHQtwXDxbTJOuUlH1AEdCIyLc_1771260918
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

David Marchand, Feb 16, 2026 at 17:52:
> Is this series still relevant?
> I see no v2.

No you can drop it. I forgot to update the patchwork entry.

Thanks!

