Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF3DC021B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 20:09:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6C7040395;
	Tue,  4 Mar 2025 21:09:31 +0100 (CET)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53]) by mails.dpdk.org (Postfix) with ESMTP id 1277D402DF
 for <dev@dpdk.org>; Tue,  4 Mar 2025 21:09:31 +0100 (CET)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5493b5bc6e8so7147472e87.2
 for <dev@dpdk.org>; Tue, 04 Mar 2025 12:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741118970; x=1741723770; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=eDTizAnwGYf5hvBm9kjLh8gfiAnAsBgBSqol2mR8cPAStUMf1c5MpG4Op9pCD3c6iu
 wHHgkPsYnGSrdryi1ATREVOQT6H4TgovjuVD5fggt/QUCVTf2Tg1n6Kps2vlpE1G+zxV
 xdt32I0XxudwrQw7S5BJGNjWZWPmBMDUlSJKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741118970; x=1741723770;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=u4tcuYemI5bW4CNQQL5V8CdBN+N/8KJG1iq/T5sdmnoHREP4qbTG2kn3PsKgR/2j6v
 BGukT00r/oZ4HhuWjflNLBqb68ND+XIz3p8iBbBi1IZRHtZfr9rC0gNW/fCkmg2Af6y8
 hSh8CYCON0eKIuk3OgCueU1oJYW3g0eQv4WZfK/G2+SWYEXpP/9NNjxH93Mne3EeO4ZY
 rmc42731xpjAoiScHTMEo5wCXU12cHKyNdRE0mt4Kp67jN7aW0WoY/+tFDbYBLvIjoFa
 h0cnXK0Wp2cpZBVvaLSPv0XJQ8XNUMy3y2MNyJqa7HVn/7BQYkxj4pAOky1kwMBbps4G
 lAlQ==
X-Gm-Message-State: AOJu0YyjWjSVlJPAgyltVAY/Sw96fHEpnyVv3mvJOOAwp7ZAkT+AhOjO
 J9DD/kf0X9Dhc6t9FhpvA61cVedEJjPQIaZsyv1EJO2FUWGsLdd9wBQmwBN3gQKKaF9Rke6grQy
 vp56SiEM3Hg/qcoPhM4y1QKQveeXjfsqZkqITxA==
X-Gm-Gg: ASbGncuzn/CnoHIzUfSM/JIieYZ8EOvrupaa2ml5jhmZhp+BzpIrk0p+NOyvSzPAUYM
 Nb3+NuE243OXWxPOgdwuFXoRSkOp9xGHRYwhpliiH02yzC9uX0T7/IXSn0gfRKA03AtGnxqS1sh
 1u/mQYx5R/uxyBb7m+UGpAC8/9wHqGM9uyK82YgUqrTxKxEE7KOHsYePxuvbEG
X-Google-Smtp-Source: AGHT+IFo3cZYaR88Kff3RNv7SuNQnZ5DhyilRZMm7UmxzAWzX/cy3Tlv505R1GUkaxbHvP+KyeMKuUAJSYqE63+9dNQ=
X-Received: by 2002:a05:6512:1196:b0:545:154:52b0 with SMTP id
 2adb3069b0e04-5497d3399c6mr144901e87.22.1741118970404; Tue, 04 Mar 2025
 12:09:30 -0800 (PST)
MIME-Version: 1.0
References: <20241108134532.130681-1-luca.vizzarro@arm.com>
 <20250303145709.126126-1-Luca.Vizzarro@arm.com>
 <20250303145709.126126-5-Luca.Vizzarro@arm.com>
In-Reply-To: <20250303145709.126126-5-Luca.Vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 4 Mar 2025 15:09:17 -0500
X-Gm-Features: AQ5f1JoRImvbK0nwppCuTW72_EvOqJ6yiRO14eg-mjS-pT-cZv-0zCE-Tm3eIt4
Message-ID: <CABD7UXMfk_TuVk7n7Vh3gPdZKdf+DkwdD0MXYr-gh30yAy-rNw@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] dts: update autodoc sorting order
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>
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

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
