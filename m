Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA79CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 17:11:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A034040615;
	Mon, 11 Aug 2025 19:11:24 +0200 (CEST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 54731400D7
 for <dev@dpdk.org>; Mon, 11 Aug 2025 19:11:23 +0200 (CEST)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-7075bcdbb0fso27293366d6.0
 for <dev@dpdk.org>; Mon, 11 Aug 2025 10:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754932282;
 x=1755537082; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1asGHHSOhWSslYlLYZRgIDEyDpPtU1EMxKS30JLBmiw=;
 b=eN1ExvNzC8pSXikAH9g87zPTyvBT0eQSJA3LTU2Cr0u94JkY6n92rZZ/5tjCO7rLYV
 S+hOeIYeTh+1iYdag1upYrrFj/8f7HdfQkekJS+/j+7wIFiQXEy6iyP7pc+Rw0YuHkNa
 hrwTQhnqjtFNEwAISCtcjWKPMdJBQj5tM2kcfS55B6SVX/NQXXtLnEvO+riZuLmA6J76
 B5MI35H3BAcFkDvNux6pI8OMCNLzNwt6+6agqOdlwXbjPUFIOSwRF9mlVzViq1cbr3sW
 dk99Vsb/U3EWyMVGCpewkwvKRqdgh2Mdim/f6WZczX3IZpCgZ5Sh/8USXIFSyiLnauxl
 xL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754932282; x=1755537082;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1asGHHSOhWSslYlLYZRgIDEyDpPtU1EMxKS30JLBmiw=;
 b=hzMtors/USjrf5sIUXcBWbTXMN08Jck1dvHT40wsVDCGkZt5CNEvZkDgirEJvdFcwe
 QdO1oiXcU0mtYh58dGH3RkloXe5qqTBgUhQFhW2GTbgwTN6ko4rWqWSOcmKEaBmA+Zmz
 fqV/qFGEfhaEfcAtIaAOryX+ccZoOggT9yIZ8jSTTHlKDK9haISnvxFfC9XMslCS9eok
 DSHYNGbhUluOoxoMbnYJ9JEonafAV8CsId13V29BbR0O9EYWenklGNSNdd2rUGZixJux
 cmaKsgL7PPGhav1fWGOoChWt8qG5vOFt0utm0tCrTN3GOK7HhRvm5Gcbba+j+xIdxKTo
 bLiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJUkwCmNpjdezjld/tz4kLo1k9wMqm9OIE9qux1E/RcWIBYUhed8u4UdPXfPU4nrPMmeQ=@dpdk.org
X-Gm-Message-State: AOJu0YxyocL8aiXjJyYWz8zOb1BK5WVgjJygceZTPbLCBvlqsL7hipHS
 hJxmaRLVkmgKWLaY1eZHxQuiz+6/bmqodYago30OXC4iFDYH2Z7fbnmMTOXXidfL78pBjS4BX6x
 Opg7lRP7JF3BWx4ynKxGPaa5e8KyOn01kB3kbQD6Ibg==
X-Gm-Gg: ASbGnctvtHnAixQDkAjcnrzKgQej9TdNl6IHAJeRXF+S3TXUD4WLqylt8+hYxWIM0or
 AZsIiBP3vwl6CykukFkwClldShhBUkzZbI+U1L7VqbprWRwPOvbxR+9RhIw5sdeJ6jEucdGxOl2
 FjF9FHz/xZ/u3Md0vt0twfXgTUYagvNIO+rCWx/m6Ao6Mem2Urvxn20KpSCMzthm8I2qFF7/wre
 nlittgkcljZ9Q716Ze03k6vnYlVFKHAszrSovS8Tw==
X-Google-Smtp-Source: AGHT+IGEW0au4/HdJpe1mymokn+oxUf5+/OY622jQoouziWl19w0+XkWH4u9OrwAQ2eiRYNha51qeMx7SBeOzEy6VzU=
X-Received: by 2002:a05:6214:234f:b0:709:31f8:fd9a with SMTP id
 6a1803df08f44-7099a3e4aa4mr181491846d6.27.1754932282456; Mon, 11 Aug 2025
 10:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <PH7PR12MB85968E4B05D92C12C963F1E2822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <20250808114909.1606758-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250808094900.5027f034@hermes.local>
 <PH7PR12MB8596C293ACF92D446DBD10508228A@PH7PR12MB8596.namprd12.prod.outlook.com>
 <CA++2-x4i2OegW0u2a6AJepCFgqjLbwzqdw+es3BqrABgqM7FZg@mail.gmail.com>
 <PH7PR12MB85965BF756C6D234FB8714068228A@PH7PR12MB8596.namprd12.prod.outlook.com>
 <CA++2-x5FZSB56rrVLU96hSosLGHybQWPFPo3VPe=y8YHZBhfqA@mail.gmail.com>
 <PH7PR12MB8596AF79DA967DCA9B68FF498228A@PH7PR12MB8596.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8596AF79DA967DCA9B68FF498228A@PH7PR12MB8596.namprd12.prod.outlook.com>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Mon, 11 Aug 2025 22:11:10 +0500
X-Gm-Features: Ac12FXw0ZDJ5F1i6Xl1-U49ZQORXjsab3TAZYLbz4vIQsdS9b6IJCdVewb4HfCc
Message-ID: <CA++2-x7QJ6F0KTeLU56AqDwAPU4wiEKes-ZCBT06ZxS_bkmwew@mail.gmail.com>
Subject: Re: [PATCH v7] app/testpmd: monitor state of primary process when
 using secondary
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>, 
 "Yigit, Ferruh" <Ferruh.Yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000004d2b43063c1a030b"
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

--0000000000004d2b43063c1a030b
Content-Type: text/plain; charset="UTF-8"

Hi Vipin,
Thank you for understanding!
As Stephen mentioned:
"There is no easy way to handle the case where primary crashes; leaving
secondary process with invalid data (dangling pointers)."

Best regards,
Khadem

--0000000000004d2b43063c1a030b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Vipin,=C2=A0<div dir=3D"auto">Thank you for understand=
ing!=C2=A0</div><div dir=3D"auto">As Stephen mentioned:=C2=A0</div><div dir=
=3D"auto"><div style=3D"" dir=3D"auto"><div style=3D"width:328px;margin:16p=
x 0px"><div style=3D"font-size:12.8px" dir=3D"auto"><div style=3D"width:328=
px;margin:16px 0px">&quot;There is no easy way to handle the case where pri=
mary crashes; leaving secondary process with invalid data (dangling pointer=
s).&quot;<br></div></div></div></div></div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">Best regards,</div><div dir=3D"auto">Khadem</div></div>

--0000000000004d2b43063c1a030b--
