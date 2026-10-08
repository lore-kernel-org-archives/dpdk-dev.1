Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E94CA600C
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 19:44:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 243E8402B8;
	Thu,  8 Oct 2026 21:44:42 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 8BFE940294
 for <dev@dpdk.org>; Thu,  8 Oct 2026 21:44:40 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2d560775ca2so17861525ad.1
 for <dev@dpdk.org>; Thu, 08 Oct 2026 12:44:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791488679; cv=none;
 d=google.com; s=arc-20260327;
 b=XGrLE0O0n9vaFlIpjNLKBoPusRgkmI8/YdtOig8wLQTeHWzCBcOK1r2UEcy4CJaupG
 zFzGuR0V0/a+eTVK04QPP0hPczbyWGEWRMX7kKpQvmJJUK4L2nFCgk6oKXeFbm1uM1iR
 Mr6m5mAQFRWMEsGtpP6dHBi2DgVJ6szL4pOBZoEVxQDL4VPB7s/t9m03FJ4LF2b9CuAO
 DII+LP4SbJD87F7h/AmalQI1m2p7AtqwzBWpqZLjcQFMxRQmdooyhirpuaEbMavANj9s
 cuWEKsLFD2ZccQGzhEiLzDXbNUAfJNemRyWCzwpOOu4rG+Rb/1ZgbtleAJNX7UTIvjxu
 +NLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=/82D461Mv26WhVIs+UAtGRUFNUci9CkDfdt7ef2DY+w=;
 fh=eUqWHLlhrxpykrabbQYbmT5B5FclN6p18glcXqrZikU=;
 b=BlKyDCITHnhGVXNGgwommh/GM6y4kkvM43+ZnAqRfloHnYaG6rM9ugLsRX24FNJbgL
 lgWnjN7mBr+flvkS5yNjt2cpgRQBkj1WaKfaoULjKfXrbt4XbF/1tnYST58kKzl3cGBm
 04gIpVMIZepjCGGOIRHT3gglI5VgKzg3eHkIpkaF0bRpp2eOd/jtZsJRfPAXeiq426Yv
 /r9Cew7cbS9yox6OUgHYk8fnQTyycwO/WhrFooG0pEf0jfU5zW8erh3EiTQcwhrYn4QB
 UT+/FWASXWa/WGdPgURn0EPo85rpeSGwobB6w+pbQr+kBrAHbCk3oejd3kBfg9rVs1LQ
 70YQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1791488679; x=1792093479; darn=dpdk.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/82D461Mv26WhVIs+UAtGRUFNUci9CkDfdt7ef2DY+w=;
 b=GE1vcIm/ycV0HMINlvu9R4LTz176K5UAePIkUsH47PXY0kXvISyD4Kb4cNXA5jxJPc
 p/vwY4g1TkUUzahL9OvstFQL7teC4V/fVQ+Tx1GH7IlMZoe4hFX1GUfIRpW+fx1Om2cI
 I+d5Lg1Hgp9GmUrT+H8uAYtGMJj3S+C9hjXuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791488679; x=1792093479;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/82D461Mv26WhVIs+UAtGRUFNUci9CkDfdt7ef2DY+w=;
 b=i1zU5IrFIskkjefXD29ataWfHrFUmOn2orw33JPLxcbQ6yBo0eSwxreHeQlVeMx0Mu
 3gHy1b+tdII0eQtJi1Yahet8785pB4zFkyxMiYeRkNi+JV4/YQ6dOx9tWPYBNm4kBtbt
 LKf+jbRHdvRGqRLeQOuCTYEkoLIIS+0mE64O0fOZDcgI0BpvbHpzC0rokgyOSauHJ6Va
 JNcbYVARRSZMmlOsj8JmA3STkdte/lhneCe1PgiY/Czt1+6yJlV/VhEcHBEa717xqKPK
 VAQCm0MZ33v5142I1z+lQ2NJUuK4HlZU/CIGzAOyxGsY3DwXBpAfaCCc2ZoN7i/oFgQp
 WitA==
X-Gm-Message-State: AFq9FYJU6wEnUbfBvlPpHdwVeYfpKoDCsNi8FDlJBLW1mqKPqe02XJa2
 7CtI50tiaEqsSCYVM5baXYTApCycQVhguB/l0jwS8UL8+/Eyr/qDsFMJsjVVoGE8R4U1JCqHd5I
 hXlKbNfT5JyujvEN9iUnx5RC354lrcvY8TlRL5arUISiAM7nz6W1x+CsW6w==
X-Gm-Gg: AYBFou2K1IUVXDfdHEHL4GRuxEQfSrXjV4Ba3cGsiIxwHdSGqeta1hJJcRcmh0bFki9
 RFEFED6hK6yJ3/xEZhHC4IgHVszONZIXWoki4inMcIuCQDWYi28B8W0TzWCjBq+RkVgu7dzFIts
 Mes/lB9pLKoqwwnboq7tYqYEVQxNhGOAhK/civpa7g9b+dgSeKkPy09y/Fwjtfb7tO6B5QGN7Sd
 4x/vTnFJmu34kLymspwJgGBdY20q8mHuXM4sar1NDEuyRFy/3HJJG4+E2aSaNKbqcF+3uWJAYsi
 7+cO2vmOgj/KdhzcNyh6Qo4eTa0TXEUqFal8ELz4tceL4zAL7Hw3ZrCTbVaAR/TjlEagcgxHjZN
 YxDQtRAhFac7jAMBr6kX4MM1T
X-Received: by 2002:a17:903:324c:b0:2e8:3d48:4d8d with SMTP id
 d9443c01a7336-2e83d485795mr2227735ad.0.1791488679336; Thu, 08 Oct 2026
 12:44:39 -0700 (PDT)
MIME-Version: 1.0
From: Dillon Ladd <dladd@iol.unh.edu>
Date: Thu, 8 Oct 2026 15:44:02 -0400
X-Gm-Features: AclHuK-ggUqawxc4gTkoBKL5gP9PwXH24z8HXedDbd2L0fegDaORHBH2PAih8Zc
Message-ID: <CAJA6v3wMHH6T20ZVgu-Ps9O4cifYUAFAXk-9S4-UkQEN05DH3w@mail.gmail.com>
Subject: October 8th, 2026 DTS Working Group Meeting Notes
To: dev@dpdk.org
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

Attendees
################################################
Dillon Ladd, UNH-IOL
Koushik Bhargav Nimoji, UNH-IOL
Andrew Bailey, UNH-IOL
Luca Vizzarro

General Discussions
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
None

Patch Discussions
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Andrew put together a list of patches ranked by priority for review:

DTS Framework:
---------------------------------------------------------------------------=
-----
1. Resolve API Imports:
https://patches.dpdk.org/project/dpdk/list/?series=3D39153
Andrew has made adjustments from Luca=E2=80=99s feedback, pending review.
This patch first, it may cause conflicts with other patches. Luca to
message Andrew if so.
2. [RFC] dts: resolve trex driver binding issue
https://patches.dpdk.org/project/dpdk/patch/20260811185509.1650102-1-knimoj=
i@iol.unh.edu/
Prioritize review, sizable change of DTS and it would be helpful for
Koushik to have feedback sooner opposed to later.

New Suites:
---------------------------------------------------------------------------=
-----
3. [v3,3/3] dts: add verify coverage for cryptodev testing
https://patches.dpdk.org/project/dpdk/list/?series=3D38682
Pending Review
4. [v2] dts: add pvp multi paths vhost performance testsuite
https://patches.dpdk.org/project/dpdk/patch/20260908144707.862960-1-knimoji=
@iol.unh.edu/
Pending Review
5. [v1] dts: add pvp multi paths virtio performance testsuite
https://patches.dpdk.org/project/dpdk/patch/20260903201155.817724-1-knimoji=
@iol.unh.edu/
Pending Review
6. [v3] dts: add ipgre test suite
Pending review

Test Suite Extensions:
---------------------------------------------------------------------------=
-----
7. [v1] dts: refactor cryptodev throughput test suite
https://patchwork.dpdk.org/project/dpdk/patch/20260827172208.139769-1-abail=
ey@iol.unh.edu/
Pending Review
8. [v1] dts: update configuration for performance test
https://patchwork.dpdk.org/project/dpdk/patch/20260805153658.345207-1-abail=
ey@iol.unh.edu/
Pending review
9. [v1] dts: add PVVP case to virtio suite
https://patches.dpdk.org/project/dpdk/patch/20260811171235.519323-1-abailey=
@iol.unh.edu/
Pending Review
10. [v7] dts: refactor flow suite with generator pattern
https://patches.dpdk.org/project/dpdk/patch/20260811170433.517663-1-abailey=
@iol.unh.edu/
Pending Review

Bug fixes:
---------------------------------------------------------------------------=
-----
11. [RFC] dts: restore unbinded ports to initial state
https://patches.dpdk.org/project/dpdk/patch/20260812194428.296334-1-knimoji=
@iol.unh.edu/
Pending Review
12. [v1] dts: remove crypto test type
https://patches.dpdk.org/project/dpdk/patch/20260806164505.642928-1-abailey=
@iol.unh.edu/
Pending Review
13. dts: update verbose output regex for VXLAN packets
https://patches.dpdk.org/project/dpdk/list/?series=3D38925
Pending Review

26.11 DTS Roadmap
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
* Finalized roadmap for 26.11 is out:
https://mails.dpdk.org/archives/dev/2026 September/345096.html
* We are done with all items on the 26.11 roadmap except the EventDev
test suite port from old-dts.
* Looking at possible work items for 2027
Eventdev functional testsuite
Koushik=E2=80=99s agentic DTS tool
Showcased to Luca
Luca noted that it could also be useful for updating/ensuring updated
documentation.

Any other business
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Next Meeting: October 22nd, 2026

--=20
Dillon Ladd
Technical Manager, Open Source
UNH Interoperability Lab
21 Madbury Rd., Ste. 100, Durham, NH 03824
dladd@iol.unh.edu
https://www.iol.unh.edu
