Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8004FEDA698
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 17:02:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9390840ED3;
	Tue,  3 Mar 2026 18:02:51 +0100 (CET)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id F25EC402AA
 for <dev@dpdk.org>; Tue,  3 Mar 2026 18:02:50 +0100 (CET)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-126ea4b77adso7583323c88.1
 for <dev@dpdk.org>; Tue, 03 Mar 2026 09:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772557370;
 x=1773162170; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:subject:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=LPdy+FbbBY9s0PiqqIVUenmMdGEd8UIFqfvODZKM0CI=;
 b=dPH93o3jljIlDqryxcei665eVLk2Kj3diynmXcuPLIbeY72Yg+/l7wqy/pAZumF95Z
 +TkJHZ9IIEmiOYQnbsccmqDcEXd/bjh+HSnAxboT0qciqh4FYn7BJ7tEhXsHLZlWYScs
 y+dEzWgsSeSRQdAnk6Vfd/xhOzgsINeuHejAZqvHE7ZC35eKWcALJGrDvke4W3aYX3fN
 uyaxB2nUmMo4P29yuO9QrL4Wmd7wB9/rq7uIk2VAw/HEke64KbSFUb3DbVtsSTxnH7o9
 z8k1qHj/hhcETUNN72eeCllv/Up3PqDDIihVv6Sfu/2pHGhPEsM/Qlm3o1o9/72wDSzg
 f67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772557370; x=1773162170;
 h=content-transfer-encoding:mime-version:message-id:subject:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LPdy+FbbBY9s0PiqqIVUenmMdGEd8UIFqfvODZKM0CI=;
 b=cCJ3ySFWdoSl0DbIKAQ9MxnMVaaWOsIk6KKqltLsupaD5Fu0Mykd0yMKunmqeYJht6
 cDEt5RyfLpcuGjPzaAFyP4TwuMY5SiVBn7vCbZxUwi3RmSy5+dqnPeEZEV9rsll/tlxz
 JVuCmLg3W5xAM0qEytepp8ayEsKbXz4U8aY0IJx/sBQ0DAi0bYCVKTmKXsH8GK8wAQaQ
 b0cmbEoumuvGiKbboq9QyxsqEuBpfFW8jreMEpLBFUwXTDXSCQZjE9PcCCtb5hGmSXd8
 BBsPh3Izpmg+bIBqtq0ecf/i1nco0jlZhXULz+3Va8zHVPbqw3G2aZLGLXsLrD6sfXF+
 K+lw==
X-Gm-Message-State: AOJu0Yyl/OHMmvLcAE7w7vn/RnPqEbv0+nrGhrxHBRflwIGl9KQRo2sW
 dnogbSxu/SJ4KKLVuDnkc9oMrh2x9VOi5x2zwC27Uw8ud9lJYFA0YoY/asYGIitiSrZJvAgClVb
 ATLfZ
X-Gm-Gg: ATEYQzx9WyexZqEJypdB5wG9t8Dmzd5CzKObD7K9LKfb7gyd3iiyRtVejy7vHZcKSk8
 SsTvjztx2ycMcHVlp2Le004so+V4q40RyD5irgai6EbpZYAyr3AVcORYRbp0AGVrHQ4YrZmwCrk
 nFR0hUD+yTPMkvJLcJvgJUgE3dwEJBUi1YiDFyZXoNg+HeCpWL+QbzVQlxOSj6hUPhgWTGo+NKb
 OCmhPTY0zBcT1PPUL6rmqOpTax7fSmaS6dKX7IFMC080vZZNmXbCluHez08Yqcc4zEX8Gi9YfmS
 st0kNoueOCk/w8kHbQHpB48x7h/hBjNontEYtGQOql7pFzgR+XpZ9vVlrh6ADLmKdXLIX21tr2W
 S4mvhZpCNoKW6ommqjUZlFTwWg5Cv3GgCugn2O3K3xNkkfAUrk1FoP+9XJ57CChT4ICffxSbBHH
 Lhi5+Kc0jNxDMvgWiitvOvrhkh8E8o45Bpj5A2bveAARXy5RJRJGvm/lQb9BZnDH+qZwNWRtlzy
 HM=
X-Received: by 2002:a05:7022:608b:b0:11e:395:7dfc with SMTP id
 a92af1059eb24-1278fc24c14mr6653962c88.28.1772557369655; 
 Tue, 03 Mar 2026 09:02:49 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdfb3f898asm8088463eec.29.2026.03.03.09.02.48
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 09:02:48 -0800 (PST)
Date: Tue, 3 Mar 2026 09:02:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: DPDK Tech Board meeting minutes 04-February-2026
Message-ID: <20260303090246.5cabbe15@phoenix.local>
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

Members Attending
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Aaron Conole
Bruce Richardson
Hemant Agrawal
Jerin Jacob
Kevin Traynor
Konstantin Ananyev
Morten Br=C3=B8rup
Patrick Robb
Stephen Hemminger (Chair)
Thomas Monjalon

NOTE
=3D=3D=3D=3D
The technical board meetings are on every second Wednesday at 3 pm UTC.
Meetings are public. DPDK community members are welcome to attend on Zoom:
https://zoom-lfx.platform.linuxfoundation.org/meeting/96459488340?password=
=3Dd808f1f6-0a28-4165-929e-5a5bcae7efeb
Agenda: https://annuel.framapad.org/p/r.0c3cc4d1e011214183872a98f6b5c7db
Minutes of previous meetings: http://core.dpdk.org/techboard/minutes

Next meeting will be on: Wednesday 4-February-2026 at 3pm UTC, and will be =
chaired by: Thomas


1. Security Mailing List Registrations
---------------------------------------
Three registration requests were reviewed: one was withdrawn due to
the requester having left the company. The board agreed that members
of the security pre-release list must be those responsible in an org
for handling security vulnerabilities. As such, Thomas took the action
to verify the applicants roles.

2. Fast Free with Multi-Segment Packets
----------------------------------------
Morten and Bruce investigated whether Fast Free can work with
multi-segment packets. Bruce implemented it in Intel scalar TX paths
and measured a small but consistent improvement. The original Fast Free
definition requires single refcount, not single segment. With Fast Free,
chains can be safely broken at TX time since no other users hold
references, allowing direct bulk return to the mempool at cleanup.

Decision: Fast Free does not imply single-segment. Drivers must check
both Fast Free and multi-segs flags independently. Failure to handle
multi-segment packets with Fast Free is a driver bug.

Action: Morten and Bruce to update the documentation.

3. Stockholm May Summit
------------------------
Stephen has submitted talks. Aaron plans a talk on AI in the CI
pipeline.

Action: Stephen to check with Nathan on CFP submission status.

4. AI-Assisted Code Review
---------------------------
Stephen requested feedback on AI review outputs, especially false
positives. The board discussed output format, preferring concise
summaries on the mailing list with detail available in Patchwork.
Reviews currently go to the test-report list via Patchwork.

AI reviews should only trigger after all CI checks pass (per David
Marchand's request), with a delay to allow superseded series to be
skipped. A manual trigger (e.g. "recheck-request: force-llm-bot")
will be available, limited to people in the MAINTAINERS file.

Vote: Board unanimously approved entrusting the API key to Patrick
Robb at UNH for hosting the review infrastructure.

Action: Thomas to transfer the API key to Patrick.

5. Python Checkpatch
---------------------
Stephen presented a Python replacement for the current shell/Perl
checkpatch, created with AI assistance. It processes a 20-patch series
in under a second vs. up to 5 minutes with the current tool. It is
tailored to DPDK rules, table-driven, and should work on Windows.

The board agreed to run both tools in parallel in CI to compare results
before switching. The new script should be added to the DPDK repository
as experimental.

Action: Stephen to submit. CI team to run it in parallel
with the existing checkpatch.

Note: Renamed to dpdk-checkpatch.py in the submission.

6. RTE Pointer Macros - Qualifier Preservation
-----------------------------------------------
The new RTE_PTR_ADD/SUB macros preserve const/volatile qualifiers
instead of stripping them. This may break code that relied on the
qualifier-stripping side effect, but the fix is trivial (use
RTE_CAST_PTR). The board considered this a bug fix.

Decision: Keep the new macros. Document the change in release notes.


7. New BPF Library Co-Maintainer
---------------------------------
Marat Khalili approved as BPF library co-maintainer alongside
Konstantin Ananyev.


8. Maintainers List Review
---------------------------
Some patches (hash library, null driver) have had no maintainer
response. Morten suggested a periodic email to maintainers to confirm
they are still active.

Action: Board to consider a periodic maintainer activity check.


9. Any Other Business
----------------------
Morten asked about Wi-Fi driver work for DPDK.
A company called Umber Networks https://umbernetworks.com=20
is exploring centralized Wi-Fi with remote radio heads.
Thomas suggested this as a Stockholm summit talk topic.

