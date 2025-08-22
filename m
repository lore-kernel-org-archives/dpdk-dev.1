Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D697CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 20:51:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 090F440A71;
	Fri, 22 Aug 2025 22:51:11 +0200 (CEST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 603E14025A
 for <dev@dpdk.org>; Fri, 22 Aug 2025 22:51:10 +0200 (CEST)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-3c4e9efb88aso1342395f8f.2
 for <dev@dpdk.org>; Fri, 22 Aug 2025 13:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755895870;
 x=1756500670; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T3hbWWfEX+C9vXtTUcvyDluCP9m5kiyQ3D5v3sYp3QQ=;
 b=YMPoGVNFar5vuV1JUHr1f6W66Cwh/QDbd5FFICnMoNSCkXqbbeMggN08sGsW/ksARF
 tWSrYaqYSaXbhurf9IBidFMkF2UUgGgPujfiEyNJNKCaLCvi2KYNCPKUzfwmQh4Albnm
 ZUeE+1Gxot+1mkOGm0Jvh3ozmpr16MHNRh+k5hr9omSnMnIa/xTLL7TlL1DhvZivJ0z2
 nm1ytk76w64IqOpA4YaP4Siw7KwvHwdfM7iFkanSAB3Ksy1L2aw72P5QacFRDM0TbvHn
 MWvQiYe8yJVVV8Ozyx2LcWELvEY/korc0RwotcvZNWKfgu+ZaIKoq7DnzZbekjyYtJVK
 lxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755895870; x=1756500670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T3hbWWfEX+C9vXtTUcvyDluCP9m5kiyQ3D5v3sYp3QQ=;
 b=VzOmirHzotFizVjKbxSFycJ6XcIpIf9OkSdLCQ4YWcQM7WYSyyCxy63b8L7rS1l4g9
 uejz0oupiEGsJAc6g7ljX7WlMtHeXjCSDHjnVXMTmnl4aPLgdxrZJOsSaoJK7ymzxLnb
 pXKhKtjQwNyhmEV97v6TMIm0IEGCIYDhM8Y4R1jn9SI3XTVu669CX3VK8YP2TqNfNgTn
 XNnQloPFDzPHkzuU4tgzeaqYqRXBobWWScDRJJBWjh1P3Dyy11gjI+cjU9ptBzsKU1mb
 IEpXbrPi6DEZN7tEzhoT7i3JSn5TVECfZG+bekc2n6Kv7bIrOsVhnItGVhmdtOxvrp6I
 rz/w==
X-Gm-Message-State: AOJu0Yy6ojBWEXHuJYLiogZwfnueFDt9qA74ZSk87TQCW908ZRBRwkBg
 4dJB8ZlwEnrNxANcy9euP1rKBdSFhZoXFlvyFw33//hEw0s3IbmoVjx1V5AbAS+NzYs=
X-Gm-Gg: ASbGncu04BoBUJ1WcZTgVgh1NznYX/mqAaNjE/CYnd+0h1moXgAwEnlUWUGNpD80v8f
 M5zUSxlFRyTDFBbehN69+k8shSKRBxM6Rn3+D9Q+0j9vwqIUD+7dCfX5AkxCWUQmg+8BgZRyB6T
 iOmpj9iKzPAwf+LNX+c72UeGLKzrS4OA6J8QdsKaeWkpcYMp2WZ5kxCFvck/BisGwq7cOk/Wx/d
 /YwLArBDYt9MwzCwmtVj5S5R4YpkZDqcr6dYK/LvVegRnpRP7uuql3ixcKYsB86X4xQksnzzeTz
 PjPGyM53Aq8BQ9yv77rEMuLjtvb4IbjMFx0QJUfBiVB/EmsOMKaHXAemwv0HW0xJSehum8FEZzz
 g+5xSw7pvVx6CNBcyJOlNAwoBzc0mEvnShUrjsVWHtvV+EnC/iI63wmOaObMcQiSaYHIAMXzd3C
 s=
X-Google-Smtp-Source: AGHT+IGc+rlWjbC+F/MAIZqMdBBxbahA7Go0QKDObICEBxLaIFRVAjaUnCBjI5dzQj1X90RxWlDZyQ==
X-Received: by 2002:a05:6000:2f83:b0:3b5:dd38:3523 with SMTP id
 ffacd0b85a97d-3c5db8aa9b9mr3149353f8f.8.1755895869709; 
 Fri, 22 Aug 2025 13:51:09 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70e4ba390sm944848f8f.12.2025.08.22.13.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 13:51:09 -0700 (PDT)
Date: Fri, 22 Aug 2025 09:50:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, "Yipeng Wang" <yipeng1.wang@intel.com>, "Sameh Gobriel"
 <sameh.gobriel@intel.com>, "Bruce Richardson" <bruce.richardson@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>
Subject: Re: [RFC 1/3] hash: move table of hash compare functions out of header
Message-ID: <20250822095045.12a04c9f@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FE5F@smartserver.smartshare.dk>
References: <20250821203646.133506-1-stephen@networkplumber.org>
 <20250821203646.133506-2-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE5F@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri, 22 Aug 2025 11:05:06 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> Nice trick explicitly indexing these here; it reduces the risk of not mat=
ching the cmp_jump_table_case.

Yes, there were bugs in other code because of table mismatches.

>=20
> Consider adding static_assert() that RTE_DIM(cmp_jump_table) =3D=3D NUM_K=
EY_CMP_CASES.

Since array is explictly sized probably not needed.


