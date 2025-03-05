Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED77C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 21:24:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CF5D402DF;
	Wed,  5 Mar 2025 22:24:58 +0100 (CET)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by mails.dpdk.org (Postfix) with ESMTP id 6AF334025F
 for <dev@dpdk.org>; Wed,  5 Mar 2025 22:24:57 +0100 (CET)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-6feafc707d3so1778107b3.1
 for <dev@dpdk.org>; Wed, 05 Mar 2025 13:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741209897; x=1741814697; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=TIGKnJQWQ/GLP9Y5/IJG6D+T5FS3oJDrfRqCWUQRE9SsFX+09tTu1KjDsJ/Qp6x7sy
 jFrYKLj+xhuPcpSVkpQKU1A4dNPbcWoMUpCbgCOaWWJ8R/7Q5i8UFjHPJW8l5gL73ktZ
 hE/g4N85pDoK1iRVq/+mSZ89oKa+EjYtwJxsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741209897; x=1741814697;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=dxRZLrszww2SxYpCVf8VH1W9/f4i1Ucha0z7lVcoIOud3OZ0d2hbuiTOsyfhC5Uq4f
 DhMm7wDdIftGXa51iqBp+eIq6xFiLrElcN/gW4gzIsf+mu8z4vcx4SHyhGNeRPgfSDeZ
 zk1yltoryvL5lyBTdnQzA45UUpCUuovyxY/l49+Gz5rweLMMndgq1HPh6PTz3QVX4ocJ
 mzn9fgGkK+XsiCzQWXHuJGGouYhTqiCyI5oZlHP+PymMb/vjxyeHJTiKhBZHCn1EQMXW
 RE43KxwA7AvDY1Uh0mM4jiLfPSK1Cg6kXnfUywTuCkZD5sViWWhO6TYRjmCNpFC3+EQe
 pu8g==
X-Gm-Message-State: AOJu0Ywa557p2SMb+RzxhWHqAfO/2KJnorV+hBOCTUJRmz7tQrnDdSji
 eecPeyhwHhftswXLPR6Skp5RjKQbH/O3rzs1O6nYb3amWLbwdxkNhTVBalB2b53g05edkTmOJPw
 sbTS2APgilTAdAI9Mcay8HXb7jJvlabEZI+0FDg==
X-Gm-Gg: ASbGncsQpbwUBgOvMUwVwT9RvCutWMOnFzFcQzUbTQPsp/mr7r10X/GsX0Pu1Xp4I4u
 7BMTo/DYusXg+zWhgGjIHNn0BdbNgxvKVJrjZfAZnLYZjtNBl9h8n7U4r5YjMLs0qP/a3N8IJc9
 zxJyKpvYNwP164PxwI8RRcyxMDQgH8BPGlfkfmvKUiefVJ+M0Jd82O23aY8EZd
X-Google-Smtp-Source: AGHT+IGZYJ9EMNIQLu0bSGyzaX6TRDxSyzxYuiM2lHdekMGP332EG9xQdzCPoiw5pRKGpNa/5lEgyh/pRJHg2SdFEIU=
X-Received: by 2002:a05:690c:6b11:b0:6ef:48ac:9d0c with SMTP id
 00721157ae682-6fda31225cbmr72841357b3.25.1741209896854; Wed, 05 Mar 2025
 13:24:56 -0800 (PST)
MIME-Version: 1.0
References: <20250224132823.196509-1-luca.vizzarro@arm.com>
 <20250224132823.196509-2-luca.vizzarro@arm.com>
In-Reply-To: <20250224132823.196509-2-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Wed, 5 Mar 2025 16:24:45 -0500
X-Gm-Features: AQ5f1Joy2U0t8UbLwvYQva4Ecz7GWl2fSqHCcgNqm0uWq3ZqoTvcuUNymNCVXIE
Message-ID: <CABD7UXMiewaR4UMPE8Ky5AJxXt0ty2z92So418Z=qzbX_foMzQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] dts: ensure runtime working directory
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>
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
