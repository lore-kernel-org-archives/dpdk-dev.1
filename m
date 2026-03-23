Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED043F483DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 18:16:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15B5440268;
	Mon, 23 Mar 2026 19:16:39 +0100 (CET)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48]) by mails.dpdk.org (Postfix) with ESMTP id 595FE4025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 19:16:38 +0100 (CET)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-668d70fabc4so1112955a12.1
 for <dev@dpdk.org>; Mon, 23 Mar 2026 11:16:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774289798; cv=none;
 d=google.com; s=arc-20240605;
 b=XGp5G+pPWWH+GtU58X5j/MVk6nSTgqIWryOL5AyHSbqKkjt604AxDQ5P68bPWj0EOL
 vEjby6tdDk05cmY1tjZT1p3eKuCnmvzMdAX9goo2n7gt8t/QSiVjqGW0oVwzG3AMd4rE
 WiOdBUMUkdFSLywkYG0MaEnpmB6Tt+HRYchIYbpnxUTqSIy50mgIpdp77ffRE6uDOCN4
 eTF0lTsjFtEvetQYeSHHFrcuQo4vekwRC84+aarZEMx7VPnKkH3s4DKXGEa5SM7IaF5S
 d4Vrm9ytBHrJyKeGncEM5KFZwC1I2hC5+YRtCjmEgMzNObtovrDvKcDLcU3IFZt0bfX1
 nkjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Lw/HhpzmSDCfq0CWz4gMY4We7eHC+yuTYlM7sU84dlo=;
 fh=YeznI9hxpSKc9M2ogwOuw1jOr23TIiQgq46wlHhQ/+c=;
 b=JzkG/UFWVPpr8kTHi9LSCFppLkei+iQ9aqZnWWeiEAT2PgHzY1/VlYL+cUkG4iiPVg
 9Qw6gE+OFUasVK0IQOGZp8cYbol0TOa5vBdJSyw3TK8QlIlKuxlsKUmXlwP66PAr85u9
 kEQho7LCMqIDr8IHG4HsBZBTzAxg9Cv0elSFcdA8LtPtsirDhv8Ee0OGB6XIGzHLp16Z
 ealpPYRNqfVOIT2v1TO28qqzqjXHHCI0HNv8n6T2CHaJ+Ey4v2lLJHYTEbyjtgDF5E7v
 L8eyWh61eopKBdoWdJ2gERLRhvLzMuS538PaUB5xCfSnGIqzMT0Wt4xHe3yD4EM3/cUw
 hcDQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1774289798; x=1774894598; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Lw/HhpzmSDCfq0CWz4gMY4We7eHC+yuTYlM7sU84dlo=;
 b=Gm3c8YRWc4/4erX309eMTvS9GaDIP30vjuXgkEj6OsFRPan7YyY+rPZYl54G6nT1tr
 t0lpIL9ZzegohQcCNEKbPX2zKePD8JP8O788jP/l4QF++GSyQjcTK6dlGIT/EZfIpjRZ
 HRsIQILuE4vQeGdCdCEFURE3Zuq5tJGE0lwYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774289798; x=1774894598;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lw/HhpzmSDCfq0CWz4gMY4We7eHC+yuTYlM7sU84dlo=;
 b=DBqrm+66kgos78HSQ005f3fT676msY6yKL6p/r53UEiGgniwfG8EJmTbYFLMZJTpok
 zuCUH4ZadH+j8h+HSoIEl+GvaMH1c558Q52Io/nm93716rnoR7HjFj9IwOA6XPzA1Tr6
 ROeLSAodNnoQvthR6LGWITIT7gufkQh38OdnWCq9+DzXwm0ja4fSh+TCYTerpa9ZDWV8
 24GO678ihZGejb/jeBByNyfb4SqzjAYgqQyC77/quAeZfjciHUH8vLVnvKPwPznFrUWn
 9p4cBpoYdxAurIoD4UT3PmxHNEpZBS/eFX4yrcUT0Uq9BdpapDlcbwdAnlrCQbx/zSi7
 iEDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNSRfRnhJnEpAof+SOw8MkSTRh0vWOJix/+RoRwc2bonn5V2KxaMBqzpE0uPDMe24PVdc=@dpdk.org
X-Gm-Message-State: AOJu0Yyw0YkORQjRpyoHNgXNzis8ATkTKgxK+epzJ147FxefgCJdGwYn
 X7dKgx2Q5h4y0FIrq4WqJ7m0RDOLhMBhsUe3IsT9Uu43ahL9xKQNIdbkSx0c4MFZof1BB93k9Gf
 NVDsCShDdnIexsBNvgtN+eU4aMaGo1j6iA/SwJteaXQ==
X-Gm-Gg: ATEYQzw3PFyKJ+rLdcJZPCJDpBFjDHprsfPcWIoCDt+SEdpIcSrsvyzog4tekYMZZfx
 usl/gmnhdepeBtRhWJ0f1SrDx8hXbyJucBGW4kyTgy19YzQDwJ4Z9c+wcVcmVBcxUH3+sblnSDp
 Cz2Z83i0cCRU8w0rC/tFXBo+Ra4w5RJV23R8FWOmwuIvZgouRNtsEcHy9fc3pF4wA4o3+3WvSQY
 Ji48jvN70Cnn3mwbsUJRVYPCKVQPlFPfaLOVojvl6dLpqohh4gy5/vB2RdSyxBWByst+JONkE/1
 7YUE0FqgrugPaqqAyig5ZKUEYRdW0CyQrFDOFk6y
X-Received: by 2002:a17:907:3f98:b0:b98:4b5e:da5e with SMTP id
 a640c23a62f3a-b984b5efa8bmr699404066b.43.1774289797910; Mon, 23 Mar 2026
 11:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260320210216.259728-1-probb@iol.unh.edu>
 <34c5ba7f-dd40-4b5b-a669-029615740ae8@arm.com>
In-Reply-To: <34c5ba7f-dd40-4b5b-a669-029615740ae8@arm.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Mon, 23 Mar 2026 14:16:26 -0400
X-Gm-Features: AQROBzDONw-tai1TMbV4OPBn7FNWx56dl67j7sWmcTdfa2e81CHA25nFRVtCh5U
Message-ID: <CABJ3N2Xtx1W-i-KcTF2eL6A=K-46_+PuKztngT2SGYd=R9fE_w@mail.gmail.com>
Subject: Re: [PATCH v1] dts: fix test suite filtering
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: Patrick Robb <probb@iol.unh.edu>, dev@dpdk.org, dmarx@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000022214f064db50980"
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

--00000000000022214f064db50980
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>

--00000000000022214f064db50980
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Reviewed-by: Andrew Bailey &lt;<a href="mailto:abailey@iol.unh.edu">abailey@iol.unh.edu</a>&gt;</div>

--00000000000022214f064db50980--
