Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A4CC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 08:42:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F8724021F;
	Thu, 12 Jun 2025 10:42:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id F36FD4003C
 for <dev@dpdk.org>; Thu, 12 Jun 2025 10:42:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749717755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UFinVI0AxvuQOZd82OEWtOvoaS63UH5ElVSlshZwa3E=;
 b=bcCWwysarvOLhicS6dL81VcnK2hQQ9+pcWXWsSVvxIQ0vlDZUK7WolV1bC7a/J3TDBD2FJ
 HnwqXFlHI2JstuLSPtF23jxy0kS4YMKTMBpDKPbXVPGPj36z0tIsSjCjxKaNA84BYA+oBQ
 u2dcOquWVfcAFWWqvUo+d61bzKroLmY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-yNO-0QZ0PXu_MN7Qm5Z_6Q-1; Thu, 12 Jun 2025 04:42:33 -0400
X-MC-Unique: yNO-0QZ0PXu_MN7Qm5Z_6Q-1
X-Mimecast-MFC-AGG-ID: yNO-0QZ0PXu_MN7Qm5Z_6Q_1749717752
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-54d65701a94so372267e87.0
 for <dev@dpdk.org>; Thu, 12 Jun 2025 01:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749717752; x=1750322552;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UFinVI0AxvuQOZd82OEWtOvoaS63UH5ElVSlshZwa3E=;
 b=pTSo7kclKPjg4h4Uu18JmhmNEh1dHf0VD5qqmByrRIyC4eRlnCK2kl6YvS5CiSv9WT
 ZE2xvu5v+L/ZMqaIPAhKbvLaKnoT0ghW8sxIexXlqZYhZ09c9ocYxllZ/45rQxdsngdx
 mvUxElXGSZm6FLZyFCQciws+Nak7Ts0mQFZFcKm2EuaIwwRJpmkcWx8lK1Jcl2UGJ49o
 gZs+4C9g0tsul0r2Xi/bWt3m2prnP0OIhXtFmgF9SR7D9Z2vLOjfthNW9FDau2+y/3J6
 fkFz67ddmiYceq3HA+xZbC5qQgC4otkv2iQ+gMUkiRKVuYNobCEBi8XIn7BEErl2XXL/
 Nkfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqsi5cpA0cR4aGkfEqcdwvNJuUUrPdW4nBefRGraepwycse2Cq7jT4xll/vDx2P3bvUsM=@dpdk.org
X-Gm-Message-State: AOJu0YyIED+LjiMrYdHEzf45S+8dCadp5acpVRf1er29JXXIypMjj/Nz
 YzPyEGLlRI6NuWcu7s51SwMfFLZVuu4fAjWF0tZWfGJfPzRKfmn/dhcSSy8iw8wSMo1m/AuW/pQ
 lBLfKLmIaLkb3ILdwxlTVOAINXchfW+d3CHPaLr7qaoLZI3aBEIBQXzAMN3pPYEK44pP86WOWtB
 BltPPxHqLAlCQ/ZC7j1yw=
X-Gm-Gg: ASbGncv60GDTFgfoC2ELqptH98grvQD3hf2jQ2S2zmPyA50+3n9qn5FYDmybZex+IN9
 9FXXMho48sYUoEmC3TbgsaJz13TuOYeBGT/NL6nztqmRDIkC+GYu+YOSbmPy0I1szTapS/KV9np
 rfbiF79A==
X-Received: by 2002:a05:6512:118c:b0:553:35c4:db08 with SMTP id
 2adb3069b0e04-5539c2267b2mr1847789e87.30.1749717752169; 
 Thu, 12 Jun 2025 01:42:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGli/tlZWAJk1ZL7RIWxn1JGe+zEZuriplm7U9nsE6GCLXNwroQRa9bgyBQ8am8i5qCui0X8if6YyTDPsUvHFw=
X-Received: by 2002:a05:6512:118c:b0:553:35c4:db08 with SMTP id
 2adb3069b0e04-5539c2267b2mr1847777e87.30.1749717751794; Thu, 12 Jun 2025
 01:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250416024253.713448-1-joshwash@google.com>
In-Reply-To: <20250416024253.713448-1-joshwash@google.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 12 Jun 2025 10:42:20 +0200
X-Gm-Features: AX0GCFu5dXzstaUXBPdT4MGQOe8MmnriBJtF4loVuezdRmSbwV4H2TslKRMUIn0
Message-ID: <CAJFAV8zcQde88JVG4HXUp1Fm-2SKCGQe49QnYTp2cOwG2m9qVg@mail.gmail.com>
Subject: Re: [PATCH] maintainers: update GVE maintainers
To: Joshua Washington <joshwash@google.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org,
 Rushil Gupta <rushilg@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oE9bdmGqkWt95DA-zVBSbeP52eanbb8hH6-Cml_yoAM_1749717752
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

On Wed, Apr 16, 2025 at 4:43=E2=80=AFAM Joshua Washington <joshwash@google.=
com> wrote:

Rushil is not working on DPDK topics anymore.

> Signed-off-by: Joshua Washington <joshwash@google.com>
Acked-by: Rushil Gupta <rushilg@google.com>


Applied, thanks.

--=20
David Marchand

