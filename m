Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C798DCA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 09:07:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6588F41144;
	Thu, 14 Aug 2025 11:07:03 +0200 (CEST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id 550ED402A8
 for <dev@dpdk.org>; Thu, 14 Aug 2025 11:07:02 +0200 (CEST)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4b109be3726so11485841cf.2
 for <dev@dpdk.org>; Thu, 14 Aug 2025 02:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1755162421;
 x=1755767221; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NvRY8EWBrsGJYepuMfrG5KC48eun9lh+njM1gF5nQcg=;
 b=txK+ghbGbQ/mPbj/kTT/AKLhsN/PzPZjcY+SpQE8FyheueuqPO6K4GZ3Fb7QcJOdKg
 nK/B2O2MrRDYYdSQMW49IOsTTdmU1Loe2FaCyQBi/bkGRdZQq74dVFA7dqUiabf698Sg
 HzKZ+x9i6+isYKkXMc8m/wJ4u2qwu+cpR0jfCO7SpIf68ENTvNuw+V+SvmDmZyaVU/KX
 BGBe15tX5H5/rtbgsRSTJaj//BDzcJewnkUmZWQBubcAbjuT7dSqGWSIAEsgqnMZAGXC
 6p/NZUuc2QRvZ2sGINAEiwTDbTcGulXjc+CXvVQR0vfv5uQpOM37ZdNS7OBKzx+xutHs
 92+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755162421; x=1755767221;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NvRY8EWBrsGJYepuMfrG5KC48eun9lh+njM1gF5nQcg=;
 b=G8LRoN43T7sQ2r+HVvx7Py1/9cwpiw7anQ3wLVZ2wy8yJQ2vIuREn3OwzfZCGHxLXh
 lPQn5VfRr1VphPHILB9qruBR9jtWUSTF9LuVx0uGjmXbquOdjj6MKctp3cpKNQWjx4lj
 hgnp3A5X6bt6G3PjGRpmtHC1TAT8MiYsVs0yjDnDVkxDTa9On6OcAa9rD7pSdwNalBXf
 DK6svorp6Rps66a67A+2GCXdzl8nHgBtPGRNNhnMV29NZJtnRMVFzkw7l6iMJvu6ZqeF
 EkQYmp0rMMArAQklmDtK+fpbwvtOgsWRLXrgJGOlc48dSRAzbPeydkxHBQo3jaxALam7
 leag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAMAybUrdqmUKaUSRRmzGPaPLvkhBI3ejh0spu9W/UNArVXGQ5lonjfAQOObng1vTVgag=@dpdk.org
X-Gm-Message-State: AOJu0Yx8T9Ms4KPIeUfVVYNGknCr6b+x7BGZeSeO+pD+tRT8G4aWuTcE
 IcdgkycQJqUHmy5Nsm/Ca1/HKY1j1kgXglb8R/MTrvE1wsRNT7BvqMe7bu8wv6pv5hzpD2zWrJB
 hEqn+bt/UsicDE7gteNT8rtc52a9bzdYQ3TIxDmLyVA==
X-Gm-Gg: ASbGnctavVtfQkDAMuAnKtqd7KZYrIqaz7LW5HejLfINas5Am8mZXDS5htbkdx5LmoW
 iurvWx1v6rtKum/MynFYBsDAya8CIK2OmMX7H6c2cwCDsKX6FZlaUnC/AoSYQ2yKIsE1u/O4b7U
 jwVvvhhSFkCLCuL/KuOgDCDMn+AgahRz7/OAiK3FIkU2YhpxBH3JucBOS7z1E/lHULP79Sr4x2M
 gSb2CfZ
X-Google-Smtp-Source: AGHT+IFA4rS1EbWEUEnBf1eJ4LNPi+x8kP6FKc+88FYE8hnUL8OOvEdgVRShTUNGIL2rRbNq5RNY8VHx9kHWr/gavnI=
X-Received: by 2002:a05:622a:5914:b0:4af:890f:ff8f with SMTP id
 d75a77b69052e-4b10a92077cmr39666441cf.6.1755162421626; Thu, 14 Aug 2025
 02:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250805132318.480413-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250812124630.2916225-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250813141614.yiwou5lbd4exybnv@ds-vm-debian.local>
In-Reply-To: <20250813141614.yiwou5lbd4exybnv@ds-vm-debian.local>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Thu, 14 Aug 2025 14:06:50 +0500
X-Gm-Features: Ac12FXwP2dJz6qGET1dqCARmTZUb5ET-O5umSPhJDePvXNX12w_1LrzPn4KVwr8
Message-ID: <CA++2-x49PJs+yF-TCQuq=Q59SGcOyzNKP4hhaGw3U3-A0axLng@mail.gmail.com>
Subject: Re: [PATCH v2] net/mlx5: fix connection tracking state item validation
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>, 
 Ali Alnubani <alialnu@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, 
 Matan Azrad <matan@nvidia.com>, dev@dpdk.org, stable@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000aa1c7a063c4f982f"
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

--000000000000aa1c7a063c4f982f
Content-Type: text/plain; charset="UTF-8"

Hi Dariusz,
Thank you for your feedback.
Please check the newer version of this patch including the requested
changes.

Best regards,
Khadem

--000000000000aa1c7a063c4f982f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi=C2=A0Dariusz,=C2=A0</div><div>Thank yo=
u for your feedback.=C2=A0</div><div>Please check the newer version of this=
 patch including the requested changes.=C2=A0</div><div><br></div><div>Best=
=C2=A0regards,=C2=A0</div><div>Khadem=C2=A0</div></div>

--000000000000aa1c7a063c4f982f--
