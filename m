Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F41CD4F35
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 02:10:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C02C402D4;
	Thu, 13 Nov 2025 03:10:55 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 88D3340151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 03:10:54 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-29586626fbeso2904635ad.0
 for <dev@dpdk.org>; Wed, 12 Nov 2025 18:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762999853; x=1763604653; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VRrNXCpIGqNgAOXs/x9QWXLp3keFnQZeXbNpzLDydWs=;
 b=jiptx821/9yyFbNY4V82FS1CCIMJSrtMNUKhWYkfLXZnN048txSJDNbGePlRyEN9Va
 nUpyUEIcL1QnIngvOhu7feSWZ3bQvvPhO63awsc/gLIgmXbuehumwqR8vme+z+SMlEnt
 OMWKqhsFgkxFoSlPXMPdorIUeXlZJP7/vfAp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762999853; x=1763604653;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VRrNXCpIGqNgAOXs/x9QWXLp3keFnQZeXbNpzLDydWs=;
 b=wnvlVX05SOkpGomUo3dcIBBOjN8nd2uaqCuhESYcdicxjQXTGJhOzNh5P4WSnIeQfK
 oOan+EjTlCDW00pZZwhlDTYHXaDWVn9r5hH5MZgrUiYKfGnGWvI3u9IqsMNu7TLMx8SL
 T7JTOalYMCl/x5Fpj8/8yj3O+nc3saZIl6AdlamXCblxNbWVHGr/zSLzsKEq8jAzNRWd
 Kn/A9GrkkgT/X3pq+n3cA69hmu3PzApKnoVloVPM/CdNugyhXRgcJe3tuKENaVk4mBnm
 cHdCmbUTzKV0cDa+EENPNXu3yOos7NlSq48pR7/uZ6bBnWAoDDysOQKjizai474bCVRG
 84ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWEDBPI7LAUqw4+SgCy/1HFTiyZfyRREkcYU6YdFOv3S9ig+rTf/8705u4wNX8yqPLD/I=@dpdk.org
X-Gm-Message-State: AOJu0YwBOHEcmNkn/0KL37waLsie+AClZ5dgMy7Q9RlqKdmbOarQow7n
 G9fFrQReZy3QTQ20N4kR8uLDbd9ze2KGk4oLXtb6B90kYpK/B3j7Om+pZ5yM0JnfeALcfrx/lrS
 woV5DCbJhhC+UwUUxvmsv36OthNxw6e4ru3Qx43EcVw==
X-Gm-Gg: ASbGnct69kLHhxFvVPebTMFu4uO/a2X1KMf5tLrzHlEo+sP2XgCJ5YS3MraW0qgm14o
 LHGX3RYaKA+RfGF8gViGxEsxcG1D2MrkUCkGcPaQVgIdCQljnzekTTgqgZ3l8gt5SOPgweLR+fJ
 fVb6qJpXOcGQ8UYX6Cv4uiJZIZ4HqAfD/2W6dzYWR6JwzAETLhv/RFG7nIIygV9mPrXSDFp2Mm8
 yRKTPBenl44yv3eky1LaAPsuYJXdnHxXYdYSZxVt7sQqR0//QRurJl1iVdlFx5qmTNZuak/6f8=
X-Google-Smtp-Source: AGHT+IGMMBVdG2BdWMfr5m3FP8F/tz8f5f33lYzYD0msMnFXot5Y2bXUzOlHvQynn0iCuATTJV/RZ21U61D/ipLynMc=
X-Received: by 2002:a17:903:1a26:b0:298:2af7:8d26 with SMTP id
 d9443c01a7336-2984ede129dmr65497915ad.54.1762999853546; Wed, 12 Nov 2025
 18:10:53 -0800 (PST)
MIME-Version: 1.0
References: <20251024185056.607160-3-dmarx@iol.unh.edu>
 <20251107215020.255182-1-dmarx@iol.unh.edu>
 <20251107215020.255182-4-dmarx@iol.unh.edu>
In-Reply-To: <20251107215020.255182-4-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 12 Nov 2025 21:09:39 -0500
X-Gm-Features: AWmQ_blU8Wij9wme-xex-b-2VWliq4nRaCD0vFRQvxb3BWWbrQO_Fp-g6Oi_HxA
Message-ID: <CAJvnSUDxQR-2_XqVp5vt34bhRug1qk7deqLR9A9_E05F4E4S2g@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] dts: add virtio forwarding test suite
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000002927c0643706485"
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

--00000000000002927c0643706485
Content-Type: text/plain; charset="UTF-8"

your final changes look good to me. I ran the PvP test across an E810 and
saw expected behavior.

Applied to next-dts, thanks Dean.

--00000000000002927c0643706485
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">your final=C2=A0changes look good to me. I ran the=C2=A0Pv=
P test across an E810 and saw expected behavior.<div><div><br></div><div>Ap=
plied to next-dts, thanks Dean.</div></div></div>

--00000000000002927c0643706485--
