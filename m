Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5450ECA5FA6
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 19:50:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76002402F0;
	Mon, 28 Sep 2026 21:50:02 +0200 (CEST)
Received: from mail-qv2-f42.google.com (mail-qv2-f42.google.com
 [74.125.230.170])
 by mails.dpdk.org (Postfix) with ESMTP id 83CAF402ED
 for <dev@dpdk.org>; Mon, 28 Sep 2026 21:50:01 +0200 (CEST)
Received: by mail-qv2-f42.google.com with SMTP id
 6a1803df08f44-9144083bddaso34779456d6.3
 for <dev@dpdk.org>; Mon, 28 Sep 2026 12:50:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790625000; cv=none;
 d=google.com; s=arc-20260327;
 b=gsv1TOGkFPkFXnNEYaxLu607ws/mG3fjb0B77fmnCs3s2jOq5XjjvC5tgoGmEa/86Z
 B317m1Es4r/VOVPXwBL9s37E2X6nyHmdTfF2wVxEYPvotXPHqq4XwEJwQ+TElsC+L7/r
 r92iS+qRK4NJxzH80/otSELI0j6Z0v+JPuByqBD7/1Sqx9yLbQChBKBqvbtAF2gD5H5s
 XYCorF0OeonnOaxyCuJ8Hn+NLXjMpoJayBT3OHf5GQfVqPbTOr5AESiG5SGnRAfZQIsK
 Q6ARzea178+e3dVYZbkuNgN5qyQocizuiInHq66scGowx64uXOmG6hks8c/y+WvbppxK
 q4uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hPcAdugdFqLlVDOTOAhFCHOHM/ZUbgfmNuXpGYpChQM=;
 fh=qyuuzndXukfeez3OyMxQvZAFJoasiBgnDAdKPalV9JE=;
 b=dalgPeZ8HCK0dbLJ1jZOUSGXm/ul1807OR+nEGHrnhe46OOCl1wbwK0NmvOMNp0Qr6
 qoBJ+1BnXgiuCnuQ/fGSep/KXMZWI5hxskmAkp8Wr1/GEbmiD6KItM+c4txcJMSTvoDe
 yrr03VGlitcJu+6wteT0K3ZPg+kAUi3AJ7qWtDR8pUlmDvkR+qnc1nsMas+hHw2fhmCV
 W4JHxtrTPf2KjAq82sxyLVjJLG3uWxxbpFsgDVfqwDSWaeY2xSuLWir9F02ZDJB11Yln
 ZyxOW2l8NZHFasSwPUY2POONvdCRN9rRFlMJdk5ddSQ7xCCyDAP+ZQyC04UCVnAMoMlP
 otGQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1790625000; x=1791229800; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hPcAdugdFqLlVDOTOAhFCHOHM/ZUbgfmNuXpGYpChQM=;
 b=XpGyAm8s8MfWJAYVJbBQtr9Z0Tj6f3jGkiYpU9T/aL3dr2/KiMQgmHgxCoXh29uVvC
 5hyshbcZQbYUTr2iz7w2/SWVU6UEtLiGm97FxliiP5xNALJeznWi8dn77JPgRS/+kf5c
 Nn65HubuyFqPVkU8TEQz+FpFXp+Mk+zG9pT3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790625000; x=1791229800;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hPcAdugdFqLlVDOTOAhFCHOHM/ZUbgfmNuXpGYpChQM=;
 b=aFVpxiJ4YSu2r6Ext7VqYx7d5AkVb0pPGfD9rnNoPk77G16T+dV3mWtm2H6Hqd55tB
 XE8+toCiOdj01rz9X9HvsWpU34Bf/ZFFbwvXkBisN5UtjWLk6tkkED9dgggOgsOkkEKP
 iLLeFDmugIp+b37/BGG5ZWhcKWL9WCpvc0PvNZ0DDrGkkZGDU+xEiowvG8shzCdvC98B
 vDq/j0tjsDQ0zaWxBNXPnwErIvBCLZ8cmXbwQWLjAZ4K328fzHAfnXrxSqG/p6h4GZzb
 HQiU1KUyBaxc22OGYjq1vjKY+6KDgmk3q+zH+K4EH3rD/NV6cTJz6B8E5vQkywzo/x/P
 6CPg==
X-Gm-Message-State: AFuF++l5/WJBprTCRZtF5meQFPRce+6eA8K7/asvlJidx40v5IGhzLkE
 kSNDgQmiKq4Stl7prjdJe2udLVdiYFG6zduRlkULsrrVwvaMacqBL994C+r218c5seuOGTLuVZj
 HkHQVC5n5ftC0W/oGJsftMLEFnu26YYVOW4j5NIiRRtzBRNBYDjmJWN0=
X-Gm-Gg: AYBFou2Hv6oQESidnTVztq90qvegnDpH7wWuQRIhyNHhuvdTat+CdoFyMon5LdLjGh/
 UW1HcprAbxr+GxlJzybGXhjErpUVquVbQ3j824yqh7hEvQjw2hPk+oqu+DPtc76mmZ/Qwrw0mCM
 z7ytm65HCMLBhn23dGz3YN588YfR9lvjhzxeA640j3ktqJVNQCoHVbyxL++LT1fJBL7vnNX6k8B
 W5TmX1teSWQtlLpNRXIxR0vdzirYX0GPksFoUj7BCJDD8/5l13JAZ9fPw/lTc8H+qoT/otHaTk/
 JsXfUFopwL3dI5WXws7PMogDvPsh0R0BzP5EHboTa4PDD5WOYEdfDI96nKm3Usu4Eku/3w==
X-Received: by 2002:a05:6214:763:b0:914:5769:dcee with SMTP id
 6a1803df08f44-9145769e533mr118649766d6.17.1790624999757; Mon, 28 Sep 2026
 12:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260327180232.443820-1-abailey@iol.unh.edu>
 <20260928192246.254752-1-abailey@iol.unh.edu>
In-Reply-To: <20260928192246.254752-1-abailey@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Mon, 28 Sep 2026 15:49:48 -0400
X-Gm-Features: AclHuK_5DcU4qMPbxQICPFSKY_95gwxsfMFO86VFIKDDwHJINkwCSPGRG3QOco0
Message-ID: <CABJ3N2Uhp2g+AuaVE6zR6vxS4Xn-L2XQPyU7_ebKhPEaqogz8Q@mail.gmail.com>
Subject: Re: [PATCH v5] dts: add ipgre test suite
To: dev@dpdk.org, luca.vizzarro@arm.com, patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000096aad065c905fd8"
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

--000000000000096aad065c905fd8
Content-Type: text/plain; charset="UTF-8"

Recheck-request: loongson-unit-loongarch-abi2

--000000000000096aad065c905fd8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Recheck-request:=C2=A0<span style=3D"color:rgb(51,51,51);f=
ont-family:&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif;font-size:=
14px">loongson-unit-loongarch-abi2</span></div>

--000000000000096aad065c905fd8--
