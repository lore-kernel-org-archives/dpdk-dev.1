Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3E3CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 15:50:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 688784042E;
	Thu,  6 Nov 2025 16:50:18 +0100 (CET)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id 1140E402B0
 for <dev@dpdk.org>; Thu,  6 Nov 2025 16:50:16 +0100 (CET)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-b9a6ff216faso914145a12.3
 for <dev@dpdk.org>; Thu, 06 Nov 2025 07:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762444216;
 x=1763049016; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fiYCGt1V6dcl7CyqkLSFULcxMM13YYUfniQSedlsv5g=;
 b=VNbv1B7LTN/ZvXsQQPUcjjuiJtz810gLQvRp9XWCL6r1I/AOomf0wKymd0x6o515q3
 HfIKa8bkQCQ49rESfylWto5/QWqOn2FvMsVDzVZaDXYhUjgCc5oPn0y7iDd5V+D5JH/3
 gROi9vgf/+V/V4r3uCgLhejUd6liGzACVkBH3E3AAyq9do4mPB2YqJ7Nzv66txUZkp1l
 NKqdgUQPe54kUA5oWhK0XFC6zcMZkWDeEJcsYfeSNntYg3NnLo0bUvxNFoZw8xEOq1Q/
 uXXPqrmVM1a6jhB+Nh9Ip7RrjwxDEIZNbJ6d2pFnAoBMhV/ExzbM2TRb26V+szxkbmBY
 UY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762444216; x=1763049016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fiYCGt1V6dcl7CyqkLSFULcxMM13YYUfniQSedlsv5g=;
 b=fSSzJ7C3R8RBPdgUp9WpTcYhXQgbJRp3taPTqlUIUSlzn+Ui2NoOArAY3SC0zUSZFT
 wAH2v1ZCOrIalACrHO1LTiEnytayIi37ZGz/+cGhSVzrdLqGWFwfgrabKhg/vbB30Wn+
 6R7xGSZ25Is99eRnam9vFuxlR1pvyIwMqC9VtAMKhP4MR2oBCED4AkP1U5aHiPkcORVg
 T4lxs/2NZQoYssHyR/6l4yY1W/25kQ6kBaClgriehvvaLwduCpKhzmSwu5TkzNx48o+g
 Ll20AEjMbW/GWUeB6fIL8+saMuq49UKp4Q0xw17wfHVwEOj7oPG2wUF5r8MwbUtKwvm9
 AN8g==
X-Gm-Message-State: AOJu0Yxckj9xT2rex5oKzp5zCGHTOf5g6Q42Q1kFFmCsg5ST564WYLGr
 nD7if6E+l2/0fL/AbtztQU8gGzG4JSoR/M56ktRUMY2tQ7VDJgQqIS6PilFOoZuzWu8=
X-Gm-Gg: ASbGncuJCOl4N8fpuFgkrAY1cPP2rE1QpHW4Kd8NJA5sHqebfZ0LwomliRoDjVw9kHT
 tZKcFfZMyp9RYtVzSXTsvnZBwcL2MPPi2XRs9qzOZSiVLOPqXIdUU3tDHfFcxO2uBL0qhPZ6cui
 ZF336GGn15yMyZuBGQkVc4kPCdoQEEXJsoj9Kd+uFep2hCAfU47EahFpAdYKI486XidsYns1oAQ
 X7hRVaBBBGppNvuVWDVSudMmFsjg5uLHuhpIz3wHwtpvjJmFLBo3D1ieYSVy9N3st1nsbJ8j5em
 wRsRY8+d2JK3XoQPfL5o4geQ8Ipa/pC9XydmqKcPqswAWuuOshj3zpqmn3awkwvME6AnjszcGp5
 qlehcnlS0tz6GikxPPZXan0pO+Y5aZjZbNuqXl1BQjsgYWliRJnNlKRbpLI3/uCf/XVPDxEkCPl
 wK4Ma7jXsAywORedwRiPz1dJ1ZFnAGUH5xxg==
X-Google-Smtp-Source: AGHT+IEcp2tFTA4+b5BoN39/L1pSZKF2ByCleIDbLL18FfNQVqETFS6AqI66grbZYyZdabuBIHSKwA==
X-Received: by 2002:a17:902:d50f:b0:28b:4ca5:d522 with SMTP id
 d9443c01a7336-2962ad95d68mr110128625ad.39.1762444216046; 
 Thu, 06 Nov 2025 07:50:16 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29650c5f011sm32667835ad.25.2025.11.06.07.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 07:50:15 -0800 (PST)
Date: Thu, 6 Nov 2025 07:50:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [RFC PATCH 05/19] graph: fix variable shadowing errors
Message-ID: <20251106075013.2912d155@phoenix>
In-Reply-To: <20251106140948.2894678-6-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251106140948.2894678-6-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu,  6 Nov 2025 14:09:34 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> The nested use of MIN/MAX macros causes shadowing due to the use of the
> hard-coded temporary variable names in the macros. We can fix this in
> graph library by using MIN_T/MAX_T macros instead, which actually makes
> more sense in some circumstances:
>=20
> * when defining SZ, use of RTE_MIN_T makes sense as the comments says it
>   is defined to be usable for compile-time evaluation.
> * for the size calculations, RTE_MAX_T is also useful as it explicitly
>   encodes the type, making it clear that we are evaluating the size
>   variables as "int" type, larger than the uin16_t size is defined as.
>=20
> Fixes: b6ef3794b866 ("graph: move node clone name func into private as co=
mmon")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

I had a patch series (not sent) for lots of these.
This is how I addressed min/max

=46rom 5c8d69c734f90a774f83aaf47bc6c61bb19f411e Mon Sep 17 00:00:00 2001
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Thu, 28 Aug 2025 09:24:54 -0700
Subject: [PATCH 06/13] eal: add more min/max helpers

Add RTE_MIN3() to handle case of RTE_MIN(RTE_MIN(...)).
Change name of local temporary variables in RTE_MAX()
to allow for combinations of RTE_MIN(RTE_MAX(...)) without
causing shadow declaration warnings.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/include/rte_common.h | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 9e7d84f929..1f0edef73f 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -799,6 +799,19 @@ __extension__ typedef uint64_t RTE_MARKER64[0];
 		_a < _b ? _a : _b; \
 	})
=20
+/**
+ * Macro to return the minimum of three numbers
+ */
+#define RTE_MIN3(a, b, c)			\
+	__extension__ ({			\
+		typeof (a) _a =3D (a);		\
+		typeof (b) _b =3D (b);		\
+		typeof (c) _c =3D (c);		\
+		_a < _b ? (_a < _c ? _a : _c)	\
+			: (_b < _c ? _b : _c);	\
+	})
+
+
 /**
  * Macro to return the minimum of two numbers
  *
@@ -814,9 +827,9 @@ __extension__ typedef uint64_t RTE_MARKER64[0];
  */
 #define RTE_MAX(a, b) \
 	__extension__ ({ \
-		typeof (a) _a =3D (a); \
-		typeof (b) _b =3D (b); \
-		_a > _b ? _a : _b; \
+		typeof (a) _ax =3D (a); \
+		typeof (b) _bx =3D (b); \
+		_ax > _bx ? _ax : _bx; \
 	})
=20
 /**
--=20
2.51.0

