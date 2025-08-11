Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A830C87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 10:51:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9404F40649;
	Mon, 11 Aug 2025 12:51:21 +0200 (CEST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id E6892400D5
 for <dev@dpdk.org>; Mon, 11 Aug 2025 12:51:20 +0200 (CEST)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-707453b0306so42622996d6.2
 for <dev@dpdk.org>; Mon, 11 Aug 2025 03:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754909480;
 x=1755514280; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=An+ZCwTd+osypf2sSIu7wtfUFlbencBX9AOreX3DWNA=;
 b=spyUw7Ucz2byk8m0zZcTxTi6b3NYLBF4DH0J9s7xkckxx0Tuxl2LQ9dRHfdVgWk/fM
 FUl5l8YShJsDn3UAaax3aEA+GM/CJ8sn32MRJk5T6QBW+lD+j4RY3EjhjVefJMHGPuF/
 /c8x7qJrkUAoaiYCrhdYDNHeN8zxFLlo3y++u2cxRleYUjdl1Nvuk9XyVAyiR+byNFKw
 7xkNNkhPUB/pRrK9klTTC3GwN7SYFsSyLxGdJn5G4rbhFLEwC08l+lpewcXMg0ckLwbN
 qHE24CAO2HjD9w75S4ybE70N8M/B6406xCvU2Qso213+n/Hl7Z6XBIOdD3X1SQtXacKL
 OkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754909480; x=1755514280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=An+ZCwTd+osypf2sSIu7wtfUFlbencBX9AOreX3DWNA=;
 b=SZxjkrk7BRyiHm67FF9QIKr2QbyycmBP+VffsG/pFnxA/y9/4AjEgo2XDSwuj0YlQ8
 8dd5pFd8meUhAXaJPl/gAbk10L4kwnxI8RhGimaVv4kKpRU1GXMlv22XhmE85x49Xzjb
 G48IbIcXo0/NHvzc1b3UZ5jfzl+/zLnxm9/sMZj0InG1NN6xc3p5LTaSV7f7BiXRK+zp
 5lrFZ/3habNbNxJV+3rnpDDTSvW1uufTKx8pF32mXYUeFxdyUsVVJTuoQjXXkXi5wk8J
 6dzgtfmheD8IVvIFQWnP1alv+L2Pr3GGED0URmvE7OwcbPjOQTymZWjabgQI038djdW+
 jKiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1HgQMSf7Nn2YPAyIgCr2ExUDqtsy96fXdopRkdolsSot+/3ZRHSXWEqQslQwUglkGHAI=@dpdk.org
X-Gm-Message-State: AOJu0YxVSf3lZGzMTvm5CvgS8xVk1vf4tya7lcSsuCyMHE/tO0YK4WA1
 WUPK0kglQBENN19FNg19vUnoqVvFVWaQP5x18c5Y6EDb6Yz/WwALK9oQSEEQVChXq2tXxLYZbCv
 vPoa1XWhKhdXK+RIYVTl8XJMFsRCss83rldgn/i/foQ==
X-Gm-Gg: ASbGnct3hgdOyuw9aK6lEAHIrgg9ECz3KeVugsT9COqD0NGgi4mj3EQ1QiwRgTAHQGN
 a7psHvuquqnN2iKx5PCQt9F21esEY8bE2JwWcmYBPWZ/FGlefqFfsHFdMIAPyCoIdSHBZRem/EF
 MZv5OO48tM3YihI55W4JlMEErYE2ADTnm7gioAyr6gO7PSI8xhy+GSOHwz6WBOu8/ITDkdbCX9Q
 tkW
X-Google-Smtp-Source: AGHT+IF5urymc8qB70S8cyQglBP+lKcZO2qDzzeVHEldKNVwJwn2R785DO0AjsS+O5BBOhEs9G3bF5QtJ7e72v81kjU=
X-Received: by 2002:a05:6214:dc9:b0:702:d7ff:27f9 with SMTP id
 6a1803df08f44-7099a3339bdmr138699486d6.24.1754909480209; Mon, 11 Aug 2025
 03:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <PH7PR12MB85968E4B05D92C12C963F1E2822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <20250808114909.1606758-1-14pwcse1224@uetpeshawar.edu.pk>
 <PH7PR12MB8596259B1F736357A7E9A3EB8228A@PH7PR12MB8596.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8596259B1F736357A7E9A3EB8228A@PH7PR12MB8596.namprd12.prod.outlook.com>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Mon, 11 Aug 2025 15:51:08 +0500
X-Gm-Features: Ac12FXwoO5kDqdw9xUJCfeeAQg7pszo6aTZ0YxC7D6Cl33xxrat4akHyFaxbUXw
Message-ID: <CA++2-x40aBF8uumQ5zp18VwR4YZ5s9eUrYWi49CPyVz+97rrZA@mail.gmail.com>
Subject: Re: [PATCH v7] app/testpmd: monitor state of primary process when
 using secondary
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>
Cc: "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "thomas@monjalon.net" <thomas@monjalon.net>, 
 "Yigit, Ferruh" <Ferruh.Yigit@amd.com>, 
 "andrew.rybchenko@oktetlabs.ru" <andrew.rybchenko@oktetlabs.ru>,
 "dev@dpdk.org" <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000002e64d5063c14b401"
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

--0000000000002e64d5063c14b401
Content-Type: text/plain; charset="UTF-8"

Hi Vipin,
Glad you got the reason.
I have only checked it in testpmd, any other application which provides
primary-secondary support could also follow the same model.
This patch only adds stability and robustness to primary-secondary
applications. Primary applications can be closed, quit or shutdown
by various reasons while secondary end-up with dangling pointers.
Without the primary application, the secondary could not do any rx or tx.

--0000000000002e64d5063c14b401
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Vipin,=C2=A0<br>=
</div><div>Glad you got the reason.=C2=A0</div><div>I have=20
only checked it in testpmd, any other application which provides primary-se=
condary=C2=A0support could also follow the same model.=C2=A0</div><div>This=
 patch only adds stability and robustness to primary-secondary applications=
. Primary applications=C2=A0can be closed, quit or shutdown=C2=A0</div><div=
>by various reasons while secondary end-up with dangling pointers.=C2=A0 =
=C2=A0</div></div>Without the primary application, the secondary could not =
do any rx or tx.=C2=A0=C2=A0</div><br></div>

--0000000000002e64d5063c14b401--
