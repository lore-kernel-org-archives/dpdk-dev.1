Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F12C5AD55
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Aug 2026 02:15:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33A4640DD6;
	Mon, 10 Aug 2026 04:15:55 +0200 (CEST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 9E69040C35
 for <dev@dpdk.org>; Mon, 10 Aug 2026 04:15:53 +0200 (CEST)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-496b7622a83so13882555e9.2
 for <dev@dpdk.org>; Sun, 09 Aug 2026 19:15:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786328153; cv=none;
 d=google.com; s=arc-20260327;
 b=oIIPx9JzQAcAWdVTq0nlfh7iiaEpNXSg19dpeIYioLuLdfqY1N+nNZju3mES+xuiiD
 xVC+W9s/dc1jP4zt/WZGNaETFzXc+Ah9sRdvLC0Po8r1FGHkyRkAdubYvPCU4C2XA7Xg
 DS2xCVsjMZdb9zKphLjVeslK0jY40HwkLLdS3hh79/CCaNEwXdnLDDI9WriYnOb41UO/
 xVj7BMm7j334rdzbpjB/yIlg9eeVKUhEybZ8wwqsoFgKNndFhKv4xnvkJTV0O73FWtpG
 YlDsyD+AjRZgvZz9d2LpSDRlOamsP9nDo/fz17t2up3X+TXq/DNOGFIwpJLI3nSqwKLb
 7XNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Uf04tGDMFIMPWIRGY86ZADaJ47y2iRqQ+MD6j8mSlAk=;
 fh=6HN0UM9FEqtqe5sONSdloewdKmgHzNB6JCnr4fbhKjQ=;
 b=rN3XnyERzmwgm+s2a6Db4/l0hRXjyOP2n6n45M22CtfHEiP9P5T6AScJ9HO9HgHrmB
 MFaZ0cQEHJBHHwpK5WmPAuPXpdHsmYk1/ahIuhscRO1jwtgTrLs4z3Mi3hfPqFkFcC6V
 Yarmt50ZS0JYS+I77tQUNCDybDSVBxowMCzNVbpxL2lQCxpKqa/iyvS/+KITPdAIQ0ic
 IGg2CwtFbOtI5c1XtScdywDaTy4vppSbhkTwjsVV1FmYmbTUcgqUo21TMXjk0EIsL66X
 3PJ7k42qS8poAjGICttUHKVdbyayYHMJ+TK7h6liki7KOuOjrySkBTvmBMzOLdyRprVq
 2NUg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786328153; x=1786932953; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Uf04tGDMFIMPWIRGY86ZADaJ47y2iRqQ+MD6j8mSlAk=;
 b=KlleSsbJfZ+BjDPK2vIlJ/xhDHJQ20E3Fp79DiJqmsJR/KrLTO+KRk/MGMpzaP1AVa
 LZfqlxijoRibdxceFvUsWexzhwtIGOhgmpIEqUc5GGjNd97H92escNxmEZ0XTEETqEMP
 r2L8zqSlAuzr/dyUisBwlR3PEi8p/oznc4a/KhV7/EoTLZib2xzC8cP2qBGxrWGSRsK2
 x/HFV4u/9YV98wwigg4hmAG5gr1krbqHjEmyaNKIq8CNem8p+/xFUPu8pqG+eH+xuWlt
 /ZlecA0f/astC7ufid2cV018iYubykdQtUdBnmvcyatG9N7oOUyma2ZSkFTXjti5/mG/
 zcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786328153; x=1786932953;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Uf04tGDMFIMPWIRGY86ZADaJ47y2iRqQ+MD6j8mSlAk=;
 b=n2DQu/4vBl/7C62S/LhcfbFJ4T5tlou2kEqMos9PR9ZrQpU6DSCvrWQnV7jT2sNtFr
 bzZ/WAa82rfXG1WjJ/IVN7F3Tqy+eLjF7MvTgYVsfaPMTrb6W4QkdBrwKEc5eGVFK0wK
 x+lFkf6PKZP+BeKwYkkGRV16tCObFVyuH3NFjcKo/M7wjLFWYPW/qqadGMzX3Sy04ZDs
 iwzFRvbgCvw9E3qUg8sQcMSc0kgEE0MSNJNJJdoVKbn3amHzpXsquqREV/Wlc7swJnsK
 OryApBYHuGzi94VxCAVj4840hUtZ5qXEfHSs5PP+MjTCF/pCBpdZsPDYXKmpvHJNSBNg
 ZyHg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqf+MneEo8LmgLGh9w6Lbcu9fupbn2DSZcXYNVMekVqFilq6xXtA+fqQ0PNKPHiTf0bmSc=@dpdk.org
X-Gm-Message-State: AOJu0Ywop5jjLOHFN3JB8gaQDglpsawUoiH1e1Inf0k4edTuwJ3aDlTy
 4W7wEMX4JIY/nQg1znADvANi0WWYmmHKNNHlHB7rdJPBlRATmJ6Uat+Nlohm9yN9VT4LZ6DY4xN
 TVTzPX4jhxxST9DTtLl2NqnmyOgr7l7U=
X-Gm-Gg: AR+sD114rAKr6V8s8ffw8+LU7DXMc/d9vilNretoP6EFFg511s53L7VQLXsK/TferEm
 ISZ7Yq0rK5ru4W8jrFnq0f1wiSJXMeM0/+Mt8wn1c4QOdxXrY433Fj99tLXCr/deSUtlL54cUMp
 AAZMmRIjRwX6YErr0Dw79SvD6z4Z8zOpgJIocZyyM0kC7/AWMxUY1qKj5b5q69wwGDaH9hurYdJ
 /5n6YBuoYyLPoLy0yPqpzFWbC9Og6Dvr72BmT+G+ivfsGXgtC4GOZOdXPuwtnV6lb7HMtj+U6WB
 bnhAaW+VoB6BMxfrQlv7JlWwkHirFIZO5UDll4Rdd6Sqdp3hhU3D3Fqbl/Hlnt6oPf1darG2UPB
 FCSmNIlrOGCkoYGbGFlRVE4FBTw9ENOuEpbqWdhY=
X-Received: by 2002:a05:600c:4513:b0:495:63e4:7f78 with SMTP id
 5b1f17b1804b1-4996198373amr191370045e9.10.1786328153035; Sun, 09 Aug 2026
 19:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260522154637.952588-1-knimoji@iol.unh.edu>
 <20260804193846.556368-1-knimoji@iol.unh.edu>
In-Reply-To: <20260804193846.556368-1-knimoji@iol.unh.edu>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Sun, 9 Aug 2026 22:15:41 -0400
X-Gm-Features: AUfX_mxfxVRL_aIDMRL1u-c4z4i9_XRPGk4iLJerN5sWAQjWiHJOTLXi8-rdoZQ
Message-ID: <CAK6Duxt40u5+Z8u2+wu58ZSa6Jx4Ot8eA3mgbxQtcd4hSRZThQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] dts: add code coverage reporting to DTS
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, abailey@iol.unh.edu, 
 lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000003981b0658a7ef46"
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

--00000000000003981b0658a7ef46
Content-Type: text/plain; charset="UTF-8"

Series applied with git rewords to clarify the patches' intents and effects.

Thanks for iterating on this to get it working Koushik.

--00000000000003981b0658a7ef46
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Series applied with git rewords to clarify the patches&#39; intents and effects.<div><br></div><div>Thanks for iterating on this to get it working Koushik.</div></div>

--00000000000003981b0658a7ef46--
