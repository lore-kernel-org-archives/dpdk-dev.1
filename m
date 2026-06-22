Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E496ECDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 12:14:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FEDD40150;
	Mon, 22 Jun 2026 14:14:08 +0200 (CEST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id 4D62140144
 for <dev@dpdk.org>; Mon, 22 Jun 2026 14:14:07 +0200 (CEST)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-5174a3d9598so37048811cf.3
 for <dev@dpdk.org>; Mon, 22 Jun 2026 05:14:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782130446; cv=none;
 d=google.com; s=arc-20240605;
 b=Tg4DM1sQuXBGoIAyuu4YmcLyaQZdGlSXvMVI2HiEnSfe9GsMn4KSreYsKYcBKwSQxf
 OHt5oSg2RQRarsaI2ZrnQIg203ibuksJ24IWFS4X4hOzyhXwjKkMqvSRqtlGFYXYGkhF
 MV1rkFS42YGp2YzG6kb5whnCpzQexzMMjCRtAKLKaSxh8nt3MqVxs6cUbPyxUUMaBQYN
 Cr4cES2+3qtpAgkoUBwp7JN0jH2AYs5D3D70tNMKzhfBkUOnBfO7OgJfu/29s0jiB6Dv
 nlWLeuNwlZ21RvaQOs+ri90VsM+4ZWX54Pl8krpgiPgOrqRo82cG1DMoMcDgY25nD34E
 F3gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jTdFw+ZTgctOuPFcNS0jmXrT2c3b1CZDcvRuCM3ZRHo=;
 fh=9hopF22WS6rcyiGIQiCZEh1VGxIFjqDMk/SKNceIjQ8=;
 b=Ox0o84g/gIloc7+UyUU5m/fMM50I6Orv80bhV/L+kgyyMMtv2JhKnKzyMP9rVsI1WQ
 UMN9HJNu8T64awsFYdN5TpR7fqbUlC7IhnVBjjverz9+1pehrBTEWUSIESzAYKDDWS7h
 G+D97qqc7Ut68kD54fsU2ss5CQAE2FNH00xzZpPwv9XdhzhjBu7r4oIsYXTk7W6nEMmZ
 mQOdgQqwAuy0A13JVNNRO0tkb/9mX9Hz4R4ii5E98adkkVPio8wdq4KKkH+FJTklq+VP
 2/oQNb1g5Xcn5UvWTwuNCq+lihtxO9d9pUr21SgFGo6K2Y2cbRzOi9Ig+zY44fFFCcZL
 JVew==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782130446; x=1782735246; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jTdFw+ZTgctOuPFcNS0jmXrT2c3b1CZDcvRuCM3ZRHo=;
 b=II5a/fxOUWjzOVh+BACYtt1+l2O/dPTqjC4Ngg5+eilrHuR3exG+kPF8yda2m30fEZ
 pjhiHieNVBZjHBAeZweS1CafqIkbIztTkZ3KDTEuaTlzhitzQA3iDwK79rYFjF5lbXDs
 CRAh3AFzZA+JZ37GNKUVJE0VZdcD+Rd/7evsOCuYiND8ZkrzztELOakVCjBhcvo2R+AM
 LsfMgTj7Y45HTjddocHVZzIqyLnBg+D4LvEt278Qj4zo2+jqafCsYI+LlaBCke/3ggFg
 HJVG7bU2EcEDgRnAJlqEJzigi8FuSaT1afoZWKfvL0IBLfbTDprhqMpk2YJF2JHAgSvg
 5a5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782130446; x=1782735246;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jTdFw+ZTgctOuPFcNS0jmXrT2c3b1CZDcvRuCM3ZRHo=;
 b=T/iNcrb+dZLwciPFKhIx6pEer2aWBzGlL9gFOn/BhlDvqrZVzWiIqArUHLG3L8GYR0
 1Iv8HeV12jpu1eWvzwcnwKf8knffmOdFNZM1kkKNRGeM8dkWyx00ks1mdwz7ctGAET2o
 D/jg9Y9s/u5/238J+VECeh10mCZAamtehUzRf7eI0bkLtAZsrnnpOK+XqWrVTz8BgKsk
 FwEKK18lSZ2XHYOcBDiFDYxAPw0cK72jVYoEJQh4VEJrrTZr/fB5goMSOAwsys3VPT6m
 Fj0i1UDtxXpYTpcC8yPcjXlsGy2qKSGNWX8JNCE74C1KdswD6mR2uYkYZP7ZWBAUt2xc
 E0KQ==
X-Gm-Message-State: AOJu0YyG6yQN2gBESK5Apzy1RC03jo5g+txR0beZBtiRnVRjw7Urmrc8
 lOZYqwp5ETQzyx8LUw7XFZ342DFKka/boyWrjMGj2KFL+5O6wJ5yffwbIJ66gKqpBMt6CHfGcPG
 hbYYOUPh8ryd95gsgQNebmxd2QnryDJk=
X-Gm-Gg: AfdE7ckoNTCBDW5fT14rh0N9ukJvhOLCpvhdW4ZA02vPCA2RuDkn8BaUeABzaG3KZJC
 CvrXnZEyK4liK29US92/uPNdjOTT3Va56CZ3EDUi7B2dqhbgsPDOlbn5dHpHS/rt9RoeZf1rNtK
 T4fvi8c3ArtWD8CCeGKal97nMs8LKO/HWcMGbS3l9DanaREOHPtUXXYANMhE8+WjZJu/pQ9eIRe
 0e6a2UwPA8o+caPp/fhGRfRhJIyHzmLN++VfXTrEbBTgNtCcm5k2wHXvMmhpod6XNj4cRBzEhOv
 05Y=
X-Received: by 2002:a05:622a:2286:b0:519:edf2:1ace with SMTP id
 d75a77b69052e-519f04804bfmr197616051cf.34.1782130446332; Mon, 22 Jun 2026
 05:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260615162446.578336-1-rbhansali@marvell.com>
In-Reply-To: <20260615162446.578336-1-rbhansali@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 22 Jun 2026 17:43:39 +0530
X-Gm-Features: AVVi8CcBboLCPHQAhS_JwQ5YR4X7XC4VnWK7lFot6DjZmNnAp8GQQ9QK9P7JhfU
Message-ID: <CALBAE1PVfstcyE_GHqp6sodbupFX_pLrOsa3UQk65A-RSy6Ojg@mail.gmail.com>
Subject: Re: [PATCH v3 01/20] net/cnxk: update mbuf next field for multi
 segment
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: dev@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 jerinj@marvell.com
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

On Mon, Jun 15, 2026 at 9:56=E2=80=AFPM Rahul Bhansali <rbhansali@marvell.c=
om> wrote:
>
> As per the requirement of rte_mbuf_raw_reset_bulk(), the mbuf's
> 'next' and 'nb_segs' fields are required to be reset.
> This reset these field for multi-segment mbufs on cn9k platform.
>
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>

Series applied to dpdk-next-net-mrvl/for-main. Thanks
