Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6042C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 07:50:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B790E402C3;
	Mon,  6 Jul 2026 09:50:38 +0200 (CEST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by mails.dpdk.org (Postfix) with ESMTP id 4D69A4027B
 for <dev@dpdk.org>; Mon,  6 Jul 2026 09:50:37 +0200 (CEST)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-80cebd41372so39185987b3.3
 for <dev@dpdk.org>; Mon, 06 Jul 2026 00:50:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783324236; cv=none;
 d=google.com; s=arc-20260327;
 b=Dw8hVpw0FPb7UsWxfA+i3Pc3x2/y84HrJebsmQTaHYNQWdaM5C3SHqhugK7JiBv3lk
 Wtlvg602pFiF0J95xUI3k4d0ScNlPxZHRPzBcF1nGgb6jo/+LYglh9gkrVHh2Q/mm5YX
 pf0WyVxvirL3inrjZqtCOL7chotk9dVJBo4VDWutA3abGh5YUqvpKvMtXRiTVJ7GLFHb
 GQgWHjopNGHT9gMeS0R0iVXqxayG8GkF+F3NYBFMGKRa8rhCJjX1FS+Bd0c76T310AVu
 a4UFDialTIIw3jh/V0TX1t1iOHD2GFVVx3DDuP6EKTG/0sNOk/Zz0suYrHw2htzOSI+K
 0z5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=SV40m7kcusSlkKc8IBWzhiHnXnlpDcyCTHNGSYWRNmY=;
 fh=rF8499T70Wjtq6pcdRS4mm/+DGVNGyRNMbBBgt2YJw0=;
 b=PNWxkKN5stmrhwyRcrctXCCvjfAKr5UPuM55SMl1ryrak6F09E78SSKnOmjYb3i3V5
 ViR5wO6AQRGWb46BmSlq6lDOCrsk+eZo+oBOfq3UTyp/ROqOLi1IrF43F9FhEh+NaH+/
 AcPjPTl81amgs2XkOHNMOsxxRUIqW1dAuBYQvNYc0mlGK4J25lVq4s4Xun1+Hjbsm14c
 jCx8pUS7wafEoCr8qOyVtvLtR6Ctds6aF0Zv5HEJmVoUPyJ4q8aHhZFGgAhfVsxMuMYr
 B9itT+Gn/ZXqrl1CE8dW9cPQr+N80JHl4nWoFAQwbhKthz765Rdd7ykka7yk3y6/Qg3f
 /Yrg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783324236; x=1783929036; darn=dpdk.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SV40m7kcusSlkKc8IBWzhiHnXnlpDcyCTHNGSYWRNmY=;
 b=e8UrHdrKLWjp9ajy/Vb8vkLTwok3S2LuBGN4YnC2xPPc5Y/Ie78ceT2a58mRrn35DN
 H/+uYj8lvsRBe1zmNIZP8z2r99m+S+R6Qfdea/2sSCmkyesYQP6qIcCuePTJ3H7e3+W1
 hUAQpktD4f4nx7M5I0UkyMZqd3XJ7u7wGj6xAmyy2skuO3afhhRD4koPQxZvXel5qQ10
 f8T6b1Pn3GTsZWXan1G2rSnkmJ9uDSMwVh9TGIDmHiCFVrusU/RiwXTdfOkUH8r2DyFZ
 JXOONOwcPkHLyt/kYVfroncb+SzIN6O/2ZDyRK6uPC2qUetaiJA4CG381qSTKp0IU8F8
 PrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783324236; x=1783929036;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SV40m7kcusSlkKc8IBWzhiHnXnlpDcyCTHNGSYWRNmY=;
 b=CJ+VPwniqWJr41dw9JuBlJ9zBJl7hl9sdisJuXzQgWLTRPgLb/2vlSpib1NwM35Lya
 WRDwHuooB43gM/YQEt1j0TbKNvSb6D4v9Vs4B7D9zWwX3XLpJ3YJYayq0EXhhv9egbef
 Kq5+6jBbs4onoHD/4twpZPVH04bnhq+JQUuUmxq5+yJAv17PwijRsDfKeam372er61Hh
 elkerijVdJWJEriU1hrvlyoaePR5o8u4pDW0Bp0HKZNaGoBN5nNuf5Rw10unXifN7Rp2
 8ebyV9Yj6zLTP5KZFgLjViwKphh+sNFkF+M65HCQLqbdG6xKan0/JBMWZFDIiRvEK3u2
 qqhw==
X-Gm-Message-State: AOJu0YxzMoZeI/oSUtOsIrwnk6uUFalRMEaPu8eOjCDJUpCTTI8GjuDv
 1ujC9HHF12NkbcRnFDgnVoWqbq6hMVm3Yno7gRvTA3r2YOatSFGlaFFpH+mxTrYiOSEi4RdvLj/
 DiExASCuO3vZdImufGyDvAf/atsxwPLtp6p7h
X-Gm-Gg: AfdE7cnv5D4pj1aDRFk3oGtoc5cJ8OGgjNVvzidpo7gn99F9qXXlBUBfFe0BBDfkHkt
 CKYEnylNQwsFxRZuK0PP/U7XaHONBPaoSmX+Z7bVPufDkVoQqEytnhUDfcsIU7jtgEdkVTNx2TF
 K7YC6yAldo2/OZBsdzMld2XrnYBvWiD9c3gqNFwCZZ4jJXk21K0OFA9/4FhDtZNofDqS4wvlL50
 VCgrwvhgr3ESvkAOU9g9nZtpFNyBehxTbiJLbrakJI1IViV96REfZrti+IdfJyuKFZ1re3sqw==
X-Received: by 2002:a05:690c:6301:b0:80a:a034:17c7 with SMTP id
 00721157ae682-81739ee7cefmr99131447b3.55.1783324236349; Mon, 06 Jul 2026
 00:50:36 -0700 (PDT)
MIME-Version: 1.0
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 6 Jul 2026 13:20:08 +0530
X-Gm-Features: AVVi8CcqLbRriVjftNe9z5iZHuRBoHOJq2AvMgT5G70JfSVK7MjQ06OPykGN7N4
Message-ID: <CALBAE1O3Kgmc38E-LS9_ioEq731-JPMp9NFCxVCTcK4QpTxxjw@mail.gmail.com>
Subject: TB meeting MoM April 15 2026
To: dpdk-dev <dev@dpdk.org>
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

MINUTES OF TECHNICAL BOARD MEETING
Date: Apr 15, 2026

MEMBERS ATTENDING
- Nathan
- Bruce
- Thomas
- Hemant
- Jerin (Chair)
- Aaron
- Kevin
- Maxime
- Stephen

NOTE: The technical board meetings every second Wednesday at
https://meet.jit.si/DPDK at 3 pm UTC.
Meetings are public, and DPDK community members are welcome to attend.

1. SUMMIT PLANNING =E2=80=94 BIRDS OF A FEATHER (BOF) SESSIONS

A discussion was held on organizing BOF sessions for the upcoming summit.

Decisions reached:
- A physical whiteboard will be placed at the conference venue for
attendees to suggest and vote on BOF topics.
- The tech board will pre-seed the whiteboard with 2=E2=80=933 initial topi=
c
ideas, with a third held as fallback.
- Attendees will be split into groups by topic interest rather than
attending all sessions simultaneously.
- Voting on session topics will use a polling tool (e.g., Polly).

Jerin will create a Slack/email thread to brainstorm and collect BOF
topic candidates ahead of the summit.

Open point: Whether to run single unified discussions or parallel
breakout groups was raised by Thomas but not fully resolved.


2. JOINT MEETING PLANNING =E2=80=94 MAY 11TH, STOCKHOLM

- A joint meeting planning session is scheduled for April 28th at
10:00 AM US Eastern. Topics will include roadmap feasibility and
project provisioning.
- The actual joint meeting will be held on May 11th in Stockholm.
- Remote participation will be available for non-voting silver members.
- Two attendance confirmations received to date.
- The May 11th tech board meeting is CANCELLED due to time constraints
and travel overlap.


3. GOVERNING BOARD PRESENTATION

- Hemant will represent both the tech board and governing board at the
upcoming presentation.
- Bruce and Nathan confirmed most updates will reflect status quo,
including ongoing AI integration work.
- Bruce recommended highlighting the BOF session planning as a notable
development for the governing board.
- Hemant is preparing slides/materials and will share with the tech
board for review within 1=E2=80=932 days.
- Hemant to send pending Tech Board meeting Minutues if any.

4. DEVELOPMENT WISHLIST

- Thomas requested the governing board allocate budget for a community
development wishlist.
- All board members (tech and governing) are encouraged to submit
ideas for future development projects.
- Jerin to follow up with Prasun to collect detailed development
ideas, pending the context email from Thomas.


5. WEBSITE REBRAND PROPOSAL

- Nathan announced a proposal from Ben Thomas to rebrand and revamp
the project website, with the goal of increasing contributors and
reviewers.
- The website has not been updated in 6=E2=80=937 years; the governing boar=
d
provided positive feedback on the wireframe and UX design.
- The proposal will be submitted to LF Creative Services by end of
this week; cost estimates expected soon.
- Nathan will circulate the redesign brief to the governing board by
Friday or Monday for review.
- A formal vote will take place at the next governing board meeting in
two weeks.
