Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF78EA3C4E
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 13:31:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF1B94028F;
	Thu,  9 Apr 2026 15:31:51 +0200 (CEST)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50]) by mails.dpdk.org (Postfix) with ESMTP id 591B840276
 for <dev@dpdk.org>; Thu,  9 Apr 2026 15:31:50 +0200 (CEST)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso678663a34.0
 for <dev@dpdk.org>; Thu, 09 Apr 2026 06:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775741509; cv=none;
 d=google.com; s=arc-20240605;
 b=b8SOatAMhB6G7gbcI7zJaJwqJt68RkCCw0nihgwsATzPpHncMX3GHZ5kl1yVXA6Kh5
 YjXnpn7HCm3sR5xo2UCa2Q/LgJKkyUCJc7NqGAq8Ket1NF2FFmXYWQmTNkQZ93QKMBSr
 icFV+nkL3dHUuDbTMgFxUDIe+oLEbozZwZm6HTnkNLazo0DS8Y3Ffn8vw/a/0Nf0FZXj
 IAGUDWmu7iOcntCFRp6VitwS3b1yccF9+9+MExGki9kj05yvvkp0YFy43L4nlQY0W1+K
 IGWng3q83mj5ADd3+ZUYWbc7d2+54+BYDz0TahoqAPZHmVKG88A03NxG0v11+S4qngbY
 Ho5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=LThScNcuX4rK1+VTMy6+PLW4MlCj8pOAil/nA2LroT8=;
 fh=SmeAyABM4rfT32CZ90spRvJxp9TgPXvzIvi7t3j/5Mk=;
 b=OYe9vltaxpx58OjFsTqkUzI2pQC3NDXH8wP669IQLtSVuC8vMs2VIm0RY4u02cDUqk
 u60jimfIK41tcPg3Eq6Oxv3hZtNPmcPhkT5dPNzuv2EozRdWeQjUfXhzc6ZmbQ2nTEKm
 THvy/x2HIqf4sYvU0Q1I2r84gfx9qX4XX4/dD/WmJQajc79DIyFE0mY4nzTYeZ13e4ru
 Wh+cL+SE/hX6fCRjJVcdpyzRvRZjCrTzavsflow/qL4sMtRw6EZ8PsbCm5zEVIwuhEx7
 FckyrSydjELiEtHW6lmaSVTgEpKbWVdUnlYOYgAEty+Tnvyv0YXUDqTN8UhurpfkFOFV
 hQMA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1775741509; x=1776346309; darn=dpdk.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LThScNcuX4rK1+VTMy6+PLW4MlCj8pOAil/nA2LroT8=;
 b=BZflj8BnnYIg0ziL5mIo8KD7AJuzNboCMF6CEbTeKK/9ngXOWb4lfGJhsOFLrVKw0L
 6WXGijSqwfRFws4UuDSWhPDMWwl3NwnaeVDIcqF9+lAuQHsM7cwEeuk6NMa1m0a4UA1u
 Kyxzh7dLSBOMV0XJ+qxiJPrwUi3AZ9OzfX/ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775741509; x=1776346309;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LThScNcuX4rK1+VTMy6+PLW4MlCj8pOAil/nA2LroT8=;
 b=XLOIgVqK8FjejKCvs4jPTqF0q/OMOOWS+xOSVVejyxgN4TqlZ6e+UIGm7LU4kj27l8
 Efc/3HOokl5Qli8NCgAF+WeTw2s5jcKhhMBT70NAXOWM6BaCDkHp/8dhSLfG9Rh+NKiR
 eelsma8y5ILpUVqfhtGZXFbMxqdmth0HQnz9Mt2Tx9sJ6Bkvo2FWcJb+stCdDjNMTSkQ
 D2GToynnd9M9BnZtYMaRXWKxKI/QxP56joNhzqkouEofJz/kfLtE96Yzz8/IY2igQLYe
 UaX0pdislf/I9/jeq1rf1XgnrWuwevfQCHGa7de9SF2R8leHBZGb9HDvFopI5MFA9Cem
 mX5A==
X-Gm-Message-State: AOJu0Yw8gqM4O3VtGtE3OcNddoZhWd9PZOrHiQWoOUSmtfmrz39m+PDz
 W5kaPnx++wMMPMLwTkMOF1BT9Yf2tt0ys3pLyALCuYQ3EF9XrdPo87xp2Gvp4yHh2LknXi1pQJM
 Adf26Ievq/bBpyA/rfct7QVrbQ9sMI2SzAunRnfhJK2RUFvpcbdzuVJk=
X-Gm-Gg: AeBDiesTygpFjfqCnO1mQpRcYZ52S22MRv5dpj+oIhiTC0XXCWbXbe9jfsZF/g5adcz
 5Pwr3uYFXuhr3mWdN5voJXn37ohS5B3sv4JZ+D+ENFWUzYWYuzcPYmah08In72Tg6v6FOjiVGRf
 8MkjgUtmfkQcUQXf01Y5cVAOeHhQ79Faxwk/cIJNlecSSUlB+GADgK2qZmiyqqPpcYaRVBm5AHz
 eZjCrAGzif9G5n6Dxeubz6mPtKgXh7I+F9sW6EwMokppotAZLdhX4EMDNeX8IdIbF5+PgzH7FvL
 9Z5iCc4yWaeVSXtQr0my+w==
X-Received: by 2002:a05:6870:9610:b0:423:cacd:a4c7 with SMTP id
 586e51a60fabf-423cacda6b9mr967206fac.28.1775741508792; Thu, 09 Apr 2026
 06:31:48 -0700 (PDT)
MIME-Version: 1.0
From: Lincoln Lavoie <lylavoie@iol.unh.edu>
Date: Thu, 9 Apr 2026 09:31:37 -0400
X-Gm-Features: AQROBzDLj3aT5SeKnXp1jBcVroz9kOXYqOgcPdbVm19ikWEONXHCcbg4YYN07lM
Message-ID: <CAOE1vsMNVvLUsmU9T9okGgZbt7xbAZu0=XadNV7OU2wY0WaPFQ@mail.gmail.com>
Subject: DTS Working Group Meeting Minutes - April 9, 2026
To: dev <dev@dpdk.org>
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
1. Lincoln Lavoie
2. Luca Vizzarro
3. Adam Hassick
4. Paul Szczepanek

Minutes

 General Discussion
--------------------------------------
* Patrick Robb left the lab, as of April 2, 2026, and is working in an
non-DPDK related roles at AMD
** Patrick has volunteered to continue serving as a DTS maintainer at
least up and through the 26.07 release.
** Patrick should have submitted a patch to update the MAINTAINERS
file to list his updated contact information
** Lincoln Lavoie will be stepping in to provide DPDK coverage from
the UNH-IOL side, while Patrick=E2=80=99s position is being refilled.

DTS 26.07 Roadmap
--------------------------------------
* https://docs.google.com/document/d/1WcAQS1IdUx9ilhWOK-Yy_CnCiG4REAgYw3gyT=
zyMnCs/edit?tab=3Dt.0
* This was not previously finalized during the previous DPDK CI
meeting, due to light attendance.
* The above was approved as the roadmap for 26.07, Lincoln will work
with Patrick to get that submitted to the community.

Patch Discussions
--------------------------------------
* dts: update modprobe command to be privileged
** https://patches.dpdk.org/project/dpdk/patch/20260403183519.496825-1-abai=
ley@iol.unh.edu/
** No objections to this patch, it=E2=80=99s reviewed.

* dts: add ipgre test suite
** https://patches.dpdk.org/project/dpdk/patch/20260327180232.443820-1-abai=
ley@iol.unh.edu/
** No issues, but still needs reviews, Luca will work on that in the
next couple of days.

* Lincoln will take an action to have the UNH developers submit an
email to describe the state of each open patch, i.e. new version
expected, or this is ready, or should be dropped, etc.

Bugzilla discussions
--------------------------------------
Dean (UNH) has created a number of bugzilla tickets for ethdev issues
identified during the 26.3 development cycle.

Any other business
--------------------------------------
* Next meeting: April 22, 2026
