Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCE2606A333
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0vi82ZU6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AC4F40687;
	Mon,  9 Nov 2026 15:45:17 +0100 (CET)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by mails.dpdk.org (Postfix) with ESMTPS id BF61C4026E
 for <dev@dpdk.org>; Mon,  9 Nov 2026 15:45:15 +0100 (CET)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-8b3541bb1a2so3981917b3.1
 for <dev@dpdk.org>; Mon, 09 Nov 2026 06:45:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794235514; cv=none;
 d=google.com; s=arc-20260327;
 b=MFkBDE0H8Ru61UAFFcDQhZZHc98E9GCx7nkpEphIrBaX6W16AHjGjO2eEyE5l/e+mh
 F3aXFS6q3PyIVCDTJOCZM7OAkgkDrVfK9orh9nBe697JPs1zYQQcxUMauMb+yCXgWTE9
 C/4Chp1kJkXgOcYDwQDTvCDxN2wcIx22uo6xjGLNN/UGjoS4DkcbRe4rM1Be5xVWdUwl
 uP/XX0KODxZN/2ngHuiDV2V8qmZbGzm5DdnHEp5BG24fw5yKo3xkCmzkQthmjLGhDWQc
 be72knv8amLbW0xSbLi4apHgLUEoJ812tRuREIiDV17lI51Sfk7q8ao4F3b1BS0T1XVA
 +WSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=UBULBrozOkOLCijEprKueayu4blgnsEGv7IihJwQqLE=;
 fh=rF8499T70Wjtq6pcdRS4mm/+DGVNGyRNMbBBgt2YJw0=;
 b=pR+mVBLHEq4P8H5oRo6a+PNd8ML8rUkqnQIdM02qvt/0JVlyvcuGuzoEiq3BMcbw+5
 eHvZpbeJBcRBz14b3SXJppDwDlpbRZkq9QKsgq8AgJ+aEfYczEh8TtgmDjVSLea9Yjbl
 9VTZrGdidPoaxNUaXsQ94D641A5vkb/b0ufJy/cFuUdC79AgJO1TJYxl7Li00Oew/SfF
 i6kLGWcD5IaL6TJK1dzNncnNqY2wfogEXwcPRaJyKEzL8knb6EvsRvu4JNqsPwZgtUWM
 tIAcX1dxNH2xy1eO224LcqLCRZ6zVa2Si4SX2n6zOgzvvMNeRni56CMFqHdvkvzMBvdi
 WN8A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794235514; x=1794840314; darn=dpdk.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UBULBrozOkOLCijEprKueayu4blgnsEGv7IihJwQqLE=;
 b=0vi82ZU6XUvaKZfTGTE+lQKmZz/2xom7E4GB/SnMqaaVENXFkOgCPoHAK58MXp6r+g
 6ruyaWJYyGWqh2CBaLc5S2ovOfJ/ahkfbUK6myGOY5u1q7BnY7zZA242xJxCtxFayrxH
 AV9eV3re0LS7dLLaR2WaHk1oeH2AoH8ZER9kbnq4BNVVsgDsM2RzHtF3+b2i2PL7jWHj
 x1YGE6MzJWyaiouOmaGbeEOg0KDCcE3xpDw9b45gnimM0VOv7m4jdDGyb6kOXrj47vc2
 jWq1TzVwS+sbY0N9/DzEuIZ7sAUNhIPo2RlUpd5F0zF3hBPHFISVYj3iKbRqWQbjx3G/
 nkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794235514; x=1794840314;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UBULBrozOkOLCijEprKueayu4blgnsEGv7IihJwQqLE=;
 b=dufDb6kAEao4tx1X7D+qos6P6tCNAHWsIui7bA7s7I8y0e09CQ+unE75wROVUMi1Bl
 ZF/enhVtgAg2tt1vfQCv9l/Gql6pv4IQoVPysVOr4EYo9HcTp7avmpRNiFBHqCEFjiuK
 zi2Epqeg8M1BiopfuDRbyxHEsxZNUyCew2UMUSW/VDk1vE8S1umurvv0SlQsY/Mnht6F
 kXxm0Xj1DQpaehHpjOT+R7r4jeW7D7Fh0YAWxlzGF3DirMsXkFDFP/KS14uZuzgOhmEZ
 L4hu5lVZN76y6/34C2IVMjacYY5TdRhTy8cIbRekq1RTYaG6dUJTtn/WUbchFZJUSra2
 PtVg==
X-Gm-Message-State: APuU4Z8wX1EHie4TwByehhotlcmY/8oKSZQVYTHNRQiMKoqjUOVmDY0T
 xXx+apj2ThctHf4BkwJ4ZEaQJWwUc4m56fYIas7OE87IaTMdblRwMS2lTzwfzudJKkPSOh2XiAW
 HJOwFHOcEmBOyZ73HNhKSJJ9yTZyUeQ4WdtFlmuI=
X-Gm-Gg: AYBFou2fM9mOjBz47XHW80JypYO6UZCY8SaPvSzrziU6O0RTyMqHMbRQJSvIVHfdeFN
 7xC4Wo6YXDBnNUMpv7/drqKXE4NfxqMP5uQNyhs1zFqyEwetJxYDCy+waAYbDe2bHOHZ8kkRqmx
 idokF+6NaLdBs1A2O0BI8HePATg1Jh000KiXyl5Rb/OKsAWddnKMo9cZVWhSqa/oIQUqD+UpRdt
 a/LJXG14X4ENyw2OzKM/LrLtn+LUtA9fZ01c2hMSEpv3QeqRal3l/38tTHkh/SIBWlvmfLS+j99
 dBY95EmTspzmOqJWDi6SEQkX+7gtw5KeRjNtD7uORY7PF9Wuiz8MV1Ez+g/v4KwFJYQ4bRuDYx0
 tVmPq5Oyyhpn5GoRHuagqKiupnH8K9hVuLv4bXPA4pvddKUb+CgvUhlblDejwSvXDVu2gI5PrWp
 EgykwlLwnH/R2XJfckydBaD913kaZENOci5b7tsJbWyscXFQx2Go+hVF2f6SyHpvOWfKQfbZ0sj
 A==
X-Received: by 2002:a05:690c:800e:20b0:8b3:4a7a:599d with SMTP id
 00721157ae682-8b36cbab0f2mr16810797b3.86.1794235514316; Mon, 09 Nov 2026
 06:45:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 9 Nov 2026 20:14:47 +0530
X-Gm-Features: AclHuK_lbD7KRcynU_90mzaicAt0dFrM4cSCamX7Zm8nXfxvWhmSn2dt_KXCmz0
Message-ID: <CALBAE1OoMsYbseYU-J77xO1dmDC0jc2wV0qg_hPOwAV-wv2BRw@mail.gmail.com>
Subject: Minutes of Technical Board Meeting - Sep 2 2026
To: dpdk-dev <dev@dpdk.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

MINUTES OF TECHNICAL BOARD MEETING
Date: Sep 2 2026

MEMBERS ATTENDING

Jerin (Chair)
Bruce
Thomas
Stephen
Maxime
Konstantin
Morten Br=C3=B8rup

NOTE: The technical board meets every second Wednesday at
https://meet.jit.si/DPDK at 3 pm UTC. Meetings are public, and DPDK
community members are welcome to attend.

# CRA INFORMATION
- Nathan sent clearer CRA information to both boards, and Bruce
confirmed it answered earlier questions.
- Nathan contacted a Linux Foundation SME, who could not join. If
clarification is still needed, Nathan will follow up by call or email.

# NEXT-YEAR SUMMIT
- Still tentative. Vienna is preferred, with Brussels as an alternative.
- Thomas proposed a Belgium event alongside FOSDEM in late January or
early February. Board members see benefits, but timing is very tight.
- Fallback option is a May event in Vienna or Brussels.
- Nathan will meet next week with Thomas, Ian, Tim, Ben, and the
events team to assess feasibility. The events team is checking venues
and costs for early February.
- No decision yet.

# HOST VULNERABILITY REPORTS
- David and Maxime are nearly done and will notify reporters soon.
- All known vulnerabilities are tracked in Bugzilla. Thomas will add
Jerin to the CC list so he can close tickets for fixed vulnerabilities
for cnxk drivers.

# MEMIF MAINTAINER
- The project needs a new maintainer. Ericsson has not followed up.
- Stephen will contact the original maintainer and Ericsson.

# QUORUM, VOTES, AND CLOSE
- No votes were taken, since quorum was not established.
