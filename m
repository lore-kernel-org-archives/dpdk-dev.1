Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A902C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 17:08:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8561E4064A;
	Thu,  6 Mar 2025 18:08:54 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 11E424025A
 for <dev@dpdk.org>; Thu,  6 Mar 2025 18:08:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741280932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QpjG2zHKGsRjyfPEePsRVi65IzN8fkPwFAEBikNWVZ8=;
 b=ZWnX7zUnJUywwlLX8D6+MO6jbAPTV4KGai8CPoCl4e5bvpPhDSkk26MKWMuc6hP1T9EKNp
 Lv43rjMiEf3ZxaKeDIKuQYvKa6GGI4/0C8cQjSSAK5X+oiMlus1Vy/ioVFJqrHOVgHDfgr
 ndtaSLkzLdwdPC7xg19uZwqWAW6nOmk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-RPjfpbyjMVydGUhLwbpl8A-1; Thu, 06 Mar 2025 12:08:51 -0500
X-MC-Unique: RPjfpbyjMVydGUhLwbpl8A-1
X-Mimecast-MFC-AGG-ID: RPjfpbyjMVydGUhLwbpl8A_1741280930
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5498d2a8b88so549117e87.1
 for <dev@dpdk.org>; Thu, 06 Mar 2025 09:08:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741280929; x=1741885729;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QpjG2zHKGsRjyfPEePsRVi65IzN8fkPwFAEBikNWVZ8=;
 b=u6fVWGTHnizwgMBOC+j9XkzdcG9WNpiPR3rlhVoDRAU7ZYArB2J6x1zqBAoGY173BT
 gW4cBvRSPZ6vY6E7zb+Fa2CrxKZSeCTvU7XGNma2cVMjpWkUWCN9aNenwp1Fi2pEMrMz
 jb5Y8AewdtQ9NhE2I8D9U4E+S8XTwPK+EksQSZv65SmUQhl5rlviJO+EoAlUO4vdGoAA
 okjCtZTq86XvYBYDsLLT0uFT0Ox7XVF1QL2oqSLBG8XYPw4r2sOwhDyB3LHeRFKJsc1+
 3yWfx5ee1MZFSbPthQyAArvmvJSBa7LzP4uR2BElCThF1gIAgQo2KwCmq8utqVC6Mku4
 OzHw==
X-Gm-Message-State: AOJu0YwhC9zFJefHiQXPV03Z87+/G2s6J/ycLu8+HMdJIhhFJasL09wF
 bUGe0mtd/xLD98ggWbTGYiXsJsMrHp1oneYVBchdnms74z7/Ewp9iwyClWVuQw+dHUQFutLx+MK
 OsiK/Lj6pn3VV0B1IUBTOI2dMZnPyTjAq44mR9n1BmCoRsbhdnQNJSbRE32adJDKE3O6Z+dXtJA
 Hu1akc34UG5MrCzAk=
X-Gm-Gg: ASbGncsR+Bo4DV6No0/e/gGIFm9FGeVEXsCtAQ/CAb8Yyzmh277ox8kthbvIDGbjxwH
 wxbFzxLiDM7fXq9NDywewxkxoOx9EORzy44YSQibiwA6jB3qKf9AD5ASAfyCJZFNa+Qx1HhkEcg
 Q=
X-Received: by 2002:a05:6512:3ca8:b0:549:7145:5d24 with SMTP id
 2adb3069b0e04-5497d389d8dmr2801617e87.46.1741280929605; 
 Thu, 06 Mar 2025 09:08:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqgy0eQg95opaELu1koXK8+6AcBJuVCxjre6TIx32QLKB/z6HSmBrrUplGi9jxcrHTWeClnKbbDvpZXZynMjM=
X-Received: by 2002:a05:6512:3ca8:b0:549:7145:5d24 with SMTP id
 2adb3069b0e04-5497d389d8dmr2801547e87.46.1741280928749; Thu, 06 Mar 2025
 09:08:48 -0800 (PST)
MIME-Version: 1.0
References: <20250304155036.383468-1-david.marchand@redhat.com>
In-Reply-To: <20250304155036.383468-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 6 Mar 2025 18:08:36 +0100
X-Gm-Features: AQ5f1Jp67jTX7UpE7LFivbo07Ub4DQ6ZmtsubZytIY-Xi7ZsS4PlAFOwijA0fog
Message-ID: <CAJFAV8zFF6hjvfDrxcn7DXgEBzd39t7K8oiWdd3ihAuOfk=p5Q@mail.gmail.com>
Subject: Re: [PATCH] ci: point at GitHub mirror.
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Aaron Conole <aconole@redhat.com>, 
 Michael Santana <maicolgabriel@hotmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FXZjcEtf-UQUV_pJRnRSB20s1LkMwy8wZ6UiyyFYCss_1741280930
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

On Tue, Mar 4, 2025 at 4:51=E2=80=AFPM David Marchand <david.marchand@redha=
t.com> wrote:
>
> We face some random failures accessing dpdk.org git when running GHA.
> Point at GitHub hosted mirror.
>
> Cc: stable@dpdk.org
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.


--=20
David Marchand

