Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30E0606A319
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=Iak0ttyC
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EF8740297;
	Mon, 19 Oct 2026 20:15:30 +0200 (CEST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id B38C74021E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 20:15:29 +0200 (CEST)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-53669f7b518so13346231cf.2
 for <dev@dpdk.org>; Mon, 19 Oct 2026 11:15:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792433729; cv=none;
 d=google.com; s=arc-20260327;
 b=iR6fTl0YKpytKszSWmrJSkLH07GCciGBvjLZsbCtOVLlyLrptGUHR04G0KsoheDb6S
 6Ld52+I1Q6RMZMI+S/JxL9ve4eorq8/4Tc9u+juANZJW4sRaIoZgTK2viJuZMB/R8qD0
 b9Te5LUgGEv5molql6QPbL21oIvzlpizv9go1Jt81ejxcHkfIjm/ZPrihP/ar7C9mrY4
 isI7L2NiKSZJut+UZn0T9i7o+7vM6bRXje6Ibi+XdwLapZ7MEJaNOIb7XYbcRZtUFzJW
 IPDVBi4I5HE7Ud9yP9GnzwiPSd83m8tKYplZiYFLR94HweBW9Yra1S8qtIkMgd75RwJT
 zPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qqyAcjzQkWIVVksXzCj9o3b/TnZLkI/+o+hht5uW/rE=;
 fh=erfZegFbk40Uj8wEwTKtU+7NWnEm87Bvz/Vv5TsA3dw=;
 b=ILsxVJCYdlwdAw0QliAMzfk6rBmIyZLPtBjec2C2RuID/O4ukwaw8FFPWxI4nc+4WQ
 52kKaoKUh2bYqna/u9IsDBNrVMOeZPNjSxFyprj0IdpKdjxrJPazOHbmNFTn+b5CvHri
 sLJH3ASRR6Xxz5NxQZx4OdGYuLdR5EbAsalLtAD20rasxyYugxFZux4MLZNm9yXl3jnK
 2/N0PbfjoJhr4PlhCo7C6W7ndPQCbvLJLP5YdXvLU+eamdqC/X7K72s8yM9pccKF5VoQ
 eFJMzbzYkR2mHEck8meDDWofm42y9R2UmHzYm1PchWUtk7sTQKwNvsHYjoEcB1d/4zpW
 fPWg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1792433729; x=1793038529; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qqyAcjzQkWIVVksXzCj9o3b/TnZLkI/+o+hht5uW/rE=;
 b=Iak0ttyCUJB3k/KGcAQCQZDhsvNun1QF/+0oN59CtoIXdzZ3lqQPf6jvXn/zPFecrz
 OJwfzSyBkq8+6xWnSs7OeE4A1mD69MUTwZoSg6lonFcxorX/ExSyMfwrGXjwU3BIdDU1
 XHKtevYV+Z41zpmIpHCBuYTZ4LEJafw2+8Zio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792433729; x=1793038529;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qqyAcjzQkWIVVksXzCj9o3b/TnZLkI/+o+hht5uW/rE=;
 b=mZKZc9IQv0WA2Z/iXO7QnnLnmRt24M62WLPHaV88vClATEAJBDTmD0kuhXYI7iINBr
 WDDFgCWSrNVq+j1AMyySdtpp/Jp7xwXJZmIVd1iZN+hQfR65rn/cBe/Chjm0WCzNBlLm
 qhRGSPYnrsJMXXEdxS1UaLKBUv1JQ2k2nMIN0yNoG0S831KAGEntbcyR2U5GlsyboMjS
 XyHw6AJSa39gqrel2EWdDESxbDNqTp27D+BhyFuElH6aawHHYnyWkPdMjACGzu9P5y63
 MQoqfN7ueiWObRJpwrqaegWqd1U8YpZBAq9S75EziZHnT7Wfp7fv94Gdnf8vrpSP1tjO
 8pfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByNbFbjlKdR6tjzM8Dp1Ct3Ic2E2gcS8bHbvWS/iZwKVZeXtj/ObBcQOgqPhM4L+YcaASQ=@dpdk.org
X-Gm-Message-State: AFq9FYJlYhZzCovnL7WCQjlJiFrPtw9JcqI2Xowy2obZVHDEw5Z610/l
 h2KN0UkyILDVwAipCbB0xisCzn3PXD4PGGSRLZHFdln9Yi3QcoizWn8xKDYCMjFGMZqbj63kMs9
 DpT7V4DcqelF7yEx1KsxurlqFVWeGIXyvWxhdVOomSQ==
X-Gm-Gg: AYBFou3pjkU8HU9pVxclYT27GY5pxQtqVJu0f2RV5PBVxlMQgtbL/j7BzBoIYFfMe8c
 buGYDiUxflrK2ZUBr9cN94VisPOES8zCrz7FwJP+s4cA+xRoq021G3VXwg6gw/0/9NcvxHDd2Vm
 dZySdZxjD6BKMXrqqmPZi9HcvWF5W1oZkg2N1nWIzuLzJE5R/C9A5fz7O8Kih3qSfCtZM65GYP8
 PmgDUSuoEUr9b3F7OZUWf/X+OSECMQIQZ7IjvlsKKTQ0bWjEoedgmmBB8vjtYuR3oOrdO9wPoww
 dZroIIN/9Ss1wtff63+k1kXSkLvX5MQpVrMLZCK0J5Vpkvn4m0d0cpjBkVYpAzPoJ+NBNg==
X-Received: by 2002:a05:622a:1906:b0:535:855e:6d15 with SMTP id
 d75a77b69052e-5364600c568mr128776621cf.30.1792433728932; Mon, 19 Oct 2026
 11:15:28 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260812194428.296334-1-knimoji@iol.unh.edu>
 <20260929134920.330389-1-knimoji@iol.unh.edu>
In-Reply-To: <20260929134920.330389-1-knimoji@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Mon, 19 Oct 2026 14:15:16 -0400
X-Gm-Features: AclHuK8QrgDIhwtJpNT8h_nHt_Cat_gKJNeNxp6EG8urmm5miSEuuQQdKz58E_4
Message-ID: <CABJ3N2VMsFvTZ9eAnEzzLGiWr4Pve_CKfry3Y9xt7yR=XPYxpA@mail.gmail.com>
Subject: Re: [PATCH v1] dts: restore unbinded ports to initial state
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: luca.vizzarro@arm.com, patrickrobb1997@gmail.com, dev@dpdk.org, 
 dladd@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000b25dd5065e357f6b"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000b25dd5065e357f6b
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>

--000000000000b25dd5065e357f6b
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr">Reviewed-by: Andrew Bailey &lt;<a href="mailto:abailey@iol.unh.edu">abailey@iol.unh.edu</a>&gt;</div>
</div>

--000000000000b25dd5065e357f6b--
