Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13183CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 15:56:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B27C402A0;
	Thu,  9 Oct 2025 17:56:37 +0200 (CEST)
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46]) by mails.dpdk.org (Postfix) with ESMTP id 2960540267
 for <dev@dpdk.org>; Thu,  9 Oct 2025 17:56:35 +0200 (CEST)
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-63bbf5f77daso1165212d50.3
 for <dev@dpdk.org>; Thu, 09 Oct 2025 08:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1760025394; x=1760630194; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=P/PUfQclXbn8OvQSQelLl3ggEAc+mX3X2TqxorUu2S6SAnuVevnJGY75TnmkH/wlM7
 DxEt24w2dIvI6mnkeDURCy+dYXN37k/RYM9BTkrNoMjuPyVq8eVF8v0wUUSGjnhosk4T
 4EsoW5gDIh5zXub/KPIMsve1MIrRJoiV93s1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760025394; x=1760630194;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=hnzCzakezPmb24rbZIhcKRwiq2kOGPWVUmyYUiZHnssnuLT3uH24OTy0kIyRa2M5jH
 W8KgQ6JsuIK/WXkSbHdgQhUgy3zdqgeGPb+6CTg+vC6T2FOOrAMtKcmUuhBOrX6xvSP7
 PS3cKp6QrN8bJnpmlWH+KxtvHxCYIP1UmJIQSeFWYBap/nYbtkqZlqokaATgmR9U0y2/
 8Dz+ti54dAKPrCZrJEzFtbYewCvY5qjLo5xrMBrx1j/naysK0/GM3ZmsAsGz6eu0BuDU
 Xp6EPDOeJ59W5tdNmFQSjb9zTWD8nd7zxJdQ3EXltOzm0WEENhhej53580/tecY4VGzM
 g8og==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+fl2sQjSoBRiIfxCSiU75tA2FlZC9ldrug1BUShPbrDf2kBUURC9H1BZlm05hz0Wh8sY=@dpdk.org
X-Gm-Message-State: AOJu0YzixEoj/2nTjx7ui1SBWI7SEP5aCmuL9U+ewqmnOqTE6mTaA93g
 XQEeIlwnLe2riVgXLWvKAs1aAhTlxcYm9biB4jX/vHG+eeC0bfreol1Kw51tPB4+GvLh73bc/74
 ZPXK3e8uVGpuvZkdVkeMpagaXLwGdRZ013Ff8o4n+Mg==
X-Gm-Gg: ASbGnct14ff116fjdrGHXRg0arx0vIbqxUh/Ef9VNP5uwFMz5VlMzINR/wbkGcvCRGK
 rEzhyJqH00+zdvimuRq7Ala+XZDKTpMa6o2Dgkrx9bCO1ZpHQBXcXNgfQ/BD0gQ3Y3vjYIC2G+m
 m9Dpfk1lBDt8w1zZmSGA8A9GV0Y2oHvQZr+RJ+E6hoLMcc6XyCG9JJj7JlvDpHnOT2eBdmXbMQ4
 dEH8Xgq5sduNvaPVQiML9KZAoBldkjlNy+/1bY2QPJPSiUw9iCBFZNU
X-Google-Smtp-Source: AGHT+IH4AIQXSMgPWPHf1THe00xSjFhAA3GKiJV8sZaFEjSMoplPnBe0xguUxVG/d6/H9F/Ao6rCTke18hyLHqqAOr8=
X-Received: by 2002:a53:b9c7:0:b0:636:d5ce:d876 with SMTP id
 956f58d0204a3-63ccb84508dmr5945954d50.13.1760025394395; Thu, 09 Oct 2025
 08:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20250929172734.218467-1-abailey@iol.unh.edu>
 <20250929172734.218467-4-abailey@iol.unh.edu>
In-Reply-To: <20250929172734.218467-4-abailey@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 9 Oct 2025 11:56:22 -0400
X-Gm-Features: AS18NWDWHynNK4qIYPEaBkoLCcpSw7OAtcf_sQfNnMVKR3Pi86qYIwY_6HRjv1g
Message-ID: <CABD7UXM4=js+2Ki-DVGKcH8ZxC9XWAA7CtRnJraNLNskkJCPTw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] dts: update tx_offload test from old dts
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, ivan.malov@arknetworks.am, 
 probb@iol.unh.edu
Content-Type: text/plain; charset="UTF-8"
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

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
