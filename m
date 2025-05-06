Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B855C3ABBC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 19:12:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7415B40261;
	Tue,  6 May 2025 21:12:56 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 231B54025D
 for <dev@dpdk.org>; Tue,  6 May 2025 21:12:55 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso7427079a12.2
 for <dev@dpdk.org>; Tue, 06 May 2025 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1746558774; x=1747163574; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mLs3G/Pwo7KDUCoT6upf0/P2lTvi7NuEzceygnja4jk=;
 b=gxoWWVKB5zQLB/oppXFYRzH6aKYxGkII51ApoNVHY4K3p/G6wDVTnECavsD8AxqriB
 glQAraljZdoZeT8NS5Qe5NUbAU5FPVbETcciU6O0ii7HuSu+t//3dSyjKHpkkRMZpTaW
 drOn0yzRrn977Wzg1bPt069cAHuCw7dEe+J1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746558774; x=1747163574;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mLs3G/Pwo7KDUCoT6upf0/P2lTvi7NuEzceygnja4jk=;
 b=Xj1ypbCZuQysENLIHfO/p1efm8zipXN7P1KBTnQGn8b4j9eDsLSLZ3Vy8P3Di223KT
 rn9li6X7vE3aOvHT7gRjEfyljQNAnkzd/fezHBVyi8vKZZpCeHJDRFPWp0ni4OHQ17Sy
 9YQ9IDAHARKeDOiAZkxxhJDJnWWUyof5TwJlpioJCoqop571riIK1XkckmZLX2ROvzK2
 RFXYFnZ5TQ7VOETl3z34az9WREr0zhTr7YtEXcMQFXbBfx8r6bCoB4AEIcj2MjdEhfgM
 28xsbstG/6CPG/QNy+/W0oACXNT1GwnEDhofZTqwY7MESTq4WlGpVw4Pvc0nxat5DvTQ
 Sxfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4KQUSTMy40wuJmBYT44GL97DQwr+GMyq9yMedM/1o8RGh2RZDdWIKCzkVstc6ZuHqrrw=@dpdk.org
X-Gm-Message-State: AOJu0YyKPTzD88Hafc2ynbWbM0eupuw+SOr5B59KiMh5nuN5pyS90PzP
 DXy6Rh88Di4vxQ6pwdVmT3O7LMEXPyXYRZvqzq/qdshiTfSRzEKapBKVsawIeU2NbzwvKiJMW8w
 BuRroEF5mMl425rSepxUil78eIhHWXA1OilhOfb29W/5J6oZ1
X-Gm-Gg: ASbGncuek0P1z8iBZbPHdJXDUoHoADV+9DtVBi+AisShTXX1R+6AbKr0ZSIxWl5BORJ
 1o4gD/7msjSAV1+lgOuPpa5MaBpiJHnyv0tVvf6m2c37tNNxY8gSiuAM5raHjXjaj5/hSn6MxxT
 THmbrtR89Q7Vj8mNoG6+rCWHIMcBjW
X-Google-Smtp-Source: AGHT+IFSO/kZWhJ/44xflpKlFgj6GAsjC5Sgwo2u078sZLiJUZAMufAIFRB9iW6L5DDPz4XVIjRamteosg641vC/CIc=
X-Received: by 2002:a17:90b:33c1:b0:30a:4f0d:a6e7 with SMTP id
 98e67ed59e1d1-30aac197cb7mr1011119a91.14.1746558763788; Tue, 06 May 2025
 12:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvnSUDfGsKk0c7Mk9jsRMxh4wO6M32quitrnkDPWHHiTZEiCA@mail.gmail.com>
 <f7tzffp7rqw.fsf@redhat.com>
In-Reply-To: <f7tzffp7rqw.fsf@redhat.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 6 May 2025 15:08:08 -0400
X-Gm-Features: ATxdqUErlXs7eroSf9h3d_bnFX7d9B8MBPyIyE66lUcH69ov-v9P7YfcrOqrFSY
Message-ID: <CAJvnSUBh+8--cnqXDtLChD+iK8s98g+t=Hi4x-HEa8iH6fpUiw@mail.gmail.com>
Subject: Re: Polling for patchseries in DPDK - the /series/ and /events/
 endpoints
To: Aaron Conole <aconole@redhat.com>
Cc: ci@dpdk.org, dev <dev@dpdk.org>, Ali Alnubani <alialnu@nvidia.com>, 
 "Brandes, Shai" <shaibran@amazon.com>, zhoumin <zhoumin@loongson.cn>, 
 "Puttaswamy, Rajesh T" <rajesh.t.puttaswamy@intel.com>
Content-Type: multipart/alternative; boundary="000000000000b20aca06347c66a6"
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

--000000000000b20aca06347c66a6
Content-Type: text/plain; charset="UTF-8"

Thanks for the clarification regarding the datetimes. Yes let's clear up
any remaining questions offline at Prague. :)

--000000000000b20aca06347c66a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the clarification regarding the datetimes. Yes =
let&#39;s clear up any remaining=C2=A0questions offline at Prague. :)</div>

--000000000000b20aca06347c66a6--
