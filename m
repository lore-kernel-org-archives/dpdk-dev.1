Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A0FC71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 07:44:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B0F3427D4;
	Wed, 18 Jun 2025 09:44:46 +0200 (CEST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id E1859427CA
 for <dev@dpdk.org>; Wed, 18 Jun 2025 09:44:43 +0200 (CEST)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4a4bb155edeso78156821cf.2
 for <dev@dpdk.org>; Wed, 18 Jun 2025 00:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750232683; x=1750837483; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+XKugvZSpLigCyKjqedDWmuax4Yw2adaY5UhCwMQU1Y=;
 b=D4/3oe0UmO0uO6yKheuGdYpw+w3/unBSTBMGzlho3a2OMYLBXTbkNOHt21z8pQJ0bN
 bOLxtN31+vUUL9mwNdw8nWfq8jg3/oKejNpY/aWrNuSoXoFMF6uFAM5sFgcyFMs4aRk0
 Sgh/1qba7Sb7gesGWHZzgTSTXr8ocVdMk/nN41EeYSHP9CkXwatveMOIA9gP9TdM8Wj0
 LrGcUpghaOcw7bzkmeB/IwpvQVUZ3MZeQrr8OrUeiuvqnht7e2qfcHiuZJJwEqeTLcnm
 cHHjKGgETn4pBi1D9VscY8G1Q7711pg19ds1Ru5siM2z/+3Ly+Lcp+GGf7klTwTGeO+A
 gbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750232683; x=1750837483;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+XKugvZSpLigCyKjqedDWmuax4Yw2adaY5UhCwMQU1Y=;
 b=w/aIEio5TdHKMQ7c8AkWFu95yufVTc8HsRmYeyeUslQj2ZNC0IvB+NH5Xy2yb6ll5Q
 fKPDgjjwXSwTjoapfiTbViPmI/RYFfvcTfk5cJ2DMV01o45PMkY5lIAmsCSfEA02z9uN
 z7eUMjWtZ0Nkf2AniytXYyfc+sIRN3bmKKidPGEvYn+f4GCSDlSfjSAWVgF4duJX0QMf
 1z5bKJ5uAlufECCqfrLTpdC3csQ1sJgj2XZvgYLRTdRdocgGGSv0S88FgdGhw8ueXSV6
 OPQgXIbhhgUAZ2cuVrdZ654omclicrjJ0hxksnD3d1XLT95wIZeKXd2WNNKtHi2DfL5Q
 +KiA==
X-Gm-Message-State: AOJu0Yy1bexW83LYCtPR4bPZx114sgPQIXLRIJSsVVhszht7W1XCQBQs
 mDcwijI46YZVciaKwnNCccpjSf1o4A1NTaFgIbeOJph34+97hxfreGtgXL6PSgxcJSNjm1jiAvd
 XYYunCWLe2PYhVE8drd3Hr0kWD+ZpJt2ZUg7j
X-Gm-Gg: ASbGncu/pD+nz56lMG6jW+/2Nkiaq8F5YIXp0QRb5HDCggpaXAHAoxLxUV4csjL/MHZ
 CR2p9pPd4cD4G5AW5VFFMR+ta9akUbRMod9Y9EwIowFQNAwqqNp2qb/6ZgXUx7ZG0SmrXL6w+PZ
 2g6NrhOsFTsyFEUoAJeZl1bZim2alZRq/YGNeb2CaP/w==
X-Google-Smtp-Source: AGHT+IHT2qViTmB+UnEH9sbtzangwEyCyD1cXxIrKgUdxl4NE1HdXrWqlmT0gw0qOM6cPGiqWTw3esFASYMnNw9lFOM=
X-Received: by 2002:ac8:7d4c:0:b0:4a7:6586:8e5 with SMTP id
 d75a77b69052e-4a76586270emr13966451cf.40.1750232683068; Wed, 18 Jun 2025
 00:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250617045607.245070-1-tirthendu.sarkar@intel.com>
In-Reply-To: <20250617045607.245070-1-tirthendu.sarkar@intel.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Wed, 18 Jun 2025 13:14:16 +0530
X-Gm-Features: AX0GCFuUMvpBZmKq1mRlJsSOFNu__rdAGR_01xKxj2T2lVEkuzNhVmthRa6uW_E
Message-ID: <CALBAE1NdVPbCE1u6vzJAF+LabC0qRgnRrqcn5fYL8GyGAEO6mg@mail.gmail.com>
Subject: Re: [PATCH] event/dlb2: add datapath support in secondary processes
To: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, pravin.pathak@intel.com
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

On Tue, Jun 17, 2025 at 6:42=E2=80=AFPM Tirthendu Sarkar
<tirthendu.sarkar@intel.com> wrote:
>
> The producer port and consumer queue addresses are configured during
> port setup. These are needed during enqueue and dequeue operations.
> For a eventdev that is configured in primary process, these need to be
> stored so that secondary processes can retrieve them for doing enueue
> and dequeue.
>
> Store producer port and consumer queue addresses during port setup and
> retrieve them back in local data during secondary init.
>
> Additionally, add checks to retrieve stored addresses in primary data pat=
h
> for ports configured in secondary.
>
> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>

Updated the git commit as follows and applied to
dpdk-next-net-eventdev/for-main. Thanks

event/dlb2: support secondary processes datapath
