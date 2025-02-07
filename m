Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22CBC02199
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 14:46:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14E3E42E80;
	Fri,  7 Feb 2025 15:46:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 46C3742DE3
 for <dev@dpdk.org>; Fri,  7 Feb 2025 15:46:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738939597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOSjcpxKAQURRqhHowNwCIOMunhHkxl1m2lP/Q6ALcE=;
 b=h/ZD6CdYXDiZSCVg8rH1aJc6Tp5eEBo1m5pVzM4dEUNGMhqlDpTtm3C85KwAQezPs2q6cN
 ua5Vc0Q4VaLS5kfC1tQwVWIPu3s2ZyluwlwAVnXd2iCqJ6JVHhmmOxT/8Cca6Rg/il/bi7
 6C845S0ayHDdXxAkWFOGncJxgpWjX0Q=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-ocw6IN8vPPOe77ajjbjFQg-1; Fri, 07 Feb 2025 09:46:36 -0500
X-MC-Unique: ocw6IN8vPPOe77ajjbjFQg-1
X-Mimecast-MFC-AGG-ID: ocw6IN8vPPOe77ajjbjFQg
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5440edfd42bso1282628e87.0
 for <dev@dpdk.org>; Fri, 07 Feb 2025 06:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738939594; x=1739544394;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pOSjcpxKAQURRqhHowNwCIOMunhHkxl1m2lP/Q6ALcE=;
 b=jghMWLc1er/lskaGKETE/vbaoEXBEJ39qGlPxkQRhAsRNnYi9HIG27DKPThgPzPw5X
 9SjfFwTVX2uUItkGXXRZkCbflqr/d+TTmc8B9iB8CSeoSMfCqvw+rGV3r54OinbmZXoX
 Rqm17EaikGvlmheYr6ad++RhUKx0frl94aCfmO7X2dCKN3WoOBu57ODu6GvH7xvExc/q
 ws1r38wcFtUe9cZUPuQ2iybJbCe6CdxUz5MxyahWRrE1pmk5jDVQCAoicFEj5QIDnoF7
 z4rJafF8xXaroTrelBAz4Mn0YbnZqZrHHQNFx/EZv1EQb/Ya+SUKnWXnSHKaR9QdCbyr
 f5tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAdYav7En2ZS0BvPVr4fMGGCopRC3vuamZC4z5Kw0xFLEoE1+s8HQP26ioR4ywZGFiJ+o=@dpdk.org
X-Gm-Message-State: AOJu0Yy4G3iBvkPSNATKXbzMRGhb7mZSCdjBCqNnSu7CZT+gsmoZioOO
 GuIvHIlpGWqpmn9/nTnNhDIUK/Jma9PvU/SpXN53AGQKYuQKLo6qoOr7D5Dn7q5U1bj5QEv85up
 q9rI61zRkJJcc1Un2oboxu3FCerIVoRRzemJHxdlpGSBAKEBaqTKSNCR+4jGrWUuaO/Ar8V8ICI
 pwoVB3ey6CJJPYYwc=
X-Gm-Gg: ASbGncuutjGxzjVY1hkRnCNgD7MxfsKxUpNnYyTfBP0256KP3TqnST98RuPyl3qY1T3
 7QoJJeNs+sTx8Mng1NR9xuW0LzEktW+SoDYKwvozTTmDTnPTgs30ckvrnz5BMdhXV
X-Received: by 2002:a05:6512:3ca9:b0:53e:385c:e86b with SMTP id
 2adb3069b0e04-54414abb09cmr1104179e87.27.1738939593877; 
 Fri, 07 Feb 2025 06:46:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGO3wuyXYczbjFMHjC7RCjMzO3z9lpWGycNG8J3Ti7eNmvfshma32feRrq5RLioHSPMO3VOh5nB5pTZ+1Lstro=
X-Received: by 2002:a05:6512:3ca9:b0:53e:385c:e86b with SMTP id
 2adb3069b0e04-54414abb09cmr1104160e87.27.1738939593484; Fri, 07 Feb 2025
 06:46:33 -0800 (PST)
MIME-Version: 1.0
References: <20250128173132.1128023-1-ndabilpuram@marvell.com>
In-Reply-To: <20250128173132.1128023-1-ndabilpuram@marvell.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 7 Feb 2025 15:46:21 +0100
X-Gm-Features: AWEUYZl49VKPMc2F-yFHe6foBaqTewIDI3IMgIM9_zmSHe2N1TnBWsl1JRzc8J0
Message-ID: <CAJFAV8wSuOcL4RFTatW7DirVQ9WeC2BxrGEBJ+g1kO2uTumY-w@mail.gmail.com>
Subject: Re: [PATCH] ptr_compress: fix build for Arm SVE enabled SoC
To: Nithin Dabilpuram <ndabilpuram@marvell.com>
Cc: jerinj@marvell.com, Paul Szczepanek <paul.szczepanek@arm.com>, dev@dpdk.org,
 stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AkjyLjH3U_cE2XhYplBewAn6i0022LRA87Rw7qUfhsY_1738939594
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

On Tue, Jan 28, 2025 at 6:31=E2=80=AFPM Nithin Dabilpuram
<ndabilpuram@marvell.com> wrote:
>
> Fix compilation issue with const conversion.
>
> Fixes: 077596a4b077 ("ptr_compress: add pointer compression library")
> Cc: stable@dpdk.org
>
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>

Checked ARM intrinsics manual, this fix seems valid.
Applied, thanks.


--=20
David Marchand

