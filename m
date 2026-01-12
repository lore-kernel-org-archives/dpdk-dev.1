Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B76D2502E
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 01:10:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4B8A4028F;
	Mon, 12 Jan 2026 02:10:24 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 18F714013F
 for <dev@dpdk.org>; Mon, 12 Jan 2026 02:10:23 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so55542695e9.1
 for <dev@dpdk.org>; Sun, 11 Jan 2026 17:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768180223;
 x=1768785023; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/mLG/UYxt2eqoO0rj5go4ggFHmOMgKxwEOdIKVSanhc=;
 b=mUE7RTxV7EpR30dKcEeE9pebwCbx8UW41GAidviP6srodgsMsZEq+JcdM+g52RJeVm
 M36/RsEWt2V+aZ5yq/2y+WDKuwnCRESOW2XHgxBe869GVGkZ59oxscf0I9wyu8Ms5Hu3
 vCqGofk4uC+mp8MjW5WsLrrDwMjNLpes99iHQP4WNiMB2XMkihTsKg9a6i5MNLtP1BQU
 N0bG9F6CTSBG/4ZXltQ3R1VIdInQUKyTbfAuz+eEAW8Lsqw7QFJbvPgYWaRts1cLlS4o
 gHqIwIB2q0sPkes0iRbzDVBgzR1GJb8bq8roaoAP4n7pzg5hVm390dmLhaTbidj0xwCg
 jz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768180223; x=1768785023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/mLG/UYxt2eqoO0rj5go4ggFHmOMgKxwEOdIKVSanhc=;
 b=Vb1kHvPYhaPU82mreNptbD36fBjd15fITOXFSJIHDBOqiy4sccpsHaGFtafhfmdJdr
 SwarwQj2GauVfG/B+ShIr72KChksAiGJyVIo+JVhaxrJjswRPTXSNS1uPkH7Rv4czxtg
 44rUcwNnJVpKJkPx7yG9NuxDyBDlPS4r2SdqrK9Bo37HUHq/TAWgStRSePJv/siTIgEZ
 WhX6lhN7838EW1t+Y+P0qjQOOHPlg4UOX3Al9RKrhkIzcyKzqHwOj4E37+a6QdQp5zzN
 Hj7EKwPSFvq3e451UqjQv6yRXjFQfsrcUg9xWpMvMFTOcl4cLJpGxCg37jSOK4+lMlaB
 vewA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHE6mD1vlS8n1JKclRmOKtH2VH7HPk+vKgwJfcF00pVbyhCiyH85DURBu//X9GFoeYHVY=@dpdk.org
X-Gm-Message-State: AOJu0Yw2G2PyLShX0wnLh2XVLfo5KPrewat0sT4HijaFfdGet+uVTcNO
 44OZz2KyrPg9ZpEzIkHGA68AIFi0mQ0DgITiu3VMRPlkQN6g2XxZ7ZVpHbl4RGR9XGE=
X-Gm-Gg: AY/fxX7Vx3z8T1OEwKRPWmIQu2UlGyC3YA/FIhztOqFV0N16IQF15gULzj3u6dCYyPQ
 mXxSG5xxmyhL1BZlBvvcj0Fk+50KTY6aTvboDP9hWVUVXXt3jgiO3ylyPABIlNNb7Xk8Fx4u2Gz
 iRN3Xoi3RlwCMaRNm3SoGj2t8tbo15ayHsvqi3e0FdgEFrnREx9RrYa06e8OpB6qpAgol7TuULy
 w0CLTolFxJLTCJcC8r/uMpifgu0T9Up61lPVudMkohhcBs/PDGmvpq64pSm70CORBhXK3TsRUxc
 16yHeCOEzsBqiqTvhUmODEvuGa3OwXLTiA9EtD8VtFbMopJHw3YIyVFR/BogUeltYJrzSRJNqng
 7nSrE9nCSvG5yjffYJ6obkPUJA2eC9xPnXbJozJ/HM5azMgczyutdqB/QR1E2SGmNTVv72wR5yq
 uwohkHRArtpbiZcpQe03j5rsUwOSijJl1EJCqTb7wyARZwSUvmNeNm
X-Google-Smtp-Source: AGHT+IEfO1WH+uhcFiO9s/3pTf753q47O3VQ3PcVoPUAyUBH0NdpOgiD8Caw2YsHe7T60fkuU2uNIg==
X-Received: by 2002:a05:600c:4ed1:b0:47d:18b0:bb9a with SMTP id
 5b1f17b1804b1-47d84b54031mr186840245e9.33.1768180222642; 
 Sun, 11 Jan 2026 17:10:22 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8717d9e7sm116092745e9.8.2026.01.11.17.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 17:10:22 -0800 (PST)
Date: Sun, 11 Jan 2026 17:10:16 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Aman Singh <aman.deep.singh@intel.com>, Ori Kam <orika@nvidia.com>,
 <dev@dpdk.org>, Bing Zhao <bingz@nvidia.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2] app/testpmd: fix flow queue job leaks
Message-ID: <20260111171016.56ea4285@phoenix.local>
In-Reply-To: <20260109152607.206389-1-dsosnowski@nvidia.com>
References: <20251118104518.1714166-1-dsosnowski@nvidia.com>
 <20260109152607.206389-1-dsosnowski@nvidia.com>
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

On Fri, 9 Jan 2026 16:26:07 +0100
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> Each enqueued async flow operation in testpmd has an associated
> queue_job struct. It is passed in user data and used to determine
> the type of operation when operation results are pulled on a given
> queue. This information informs the necessary additional handling
> (e.g., freeing flow struct or dumping the queried action state).
>=20
> If async flow operations were enqueued and results were not pulled
> before quitting testpmd, these queue_job structs were leaked as reported
> by ASAN:
>=20
> Direct leak of 88 byte(s) in 1 object(s) allocated from:
>     #0 0x7f7539084a37 in __interceptor_calloc
>         ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
>     #1 0x55a872c8e512 in port_queue_flow_create
>         (/download/dpdk/install/bin/dpdk-testpmd+0x4cd512)
>     #2 0x55a872c28414 in cmd_flow_cb
>         (/download/dpdk/install/bin/dpdk-testpmd+0x467414)
>     #3 0x55a8734fa6a3 in __cmdline_parse
>         (/download/dpdk/install/bin/dpdk-testpmd+0xd396a3)
>     #4 0x55a8734f6130 in cmdline_valid_buffer
>         (/download/dpdk/install/bin/dpdk-testpmd+0xd35130)
>     #5 0x55a873503b4f in rdline_char_in
>         (/download/dpdk/install/bin/dpdk-testpmd+0xd42b4f)
>     #6 0x55a8734f62ba in cmdline_in
>         (/download/dpdk/install/bin/dpdk-testpmd+0xd352ba)
>     #7 0x55a8734f65eb in cmdline_interact
>         (/download/dpdk/install/bin/dpdk-testpmd+0xd355eb)
>     #8 0x55a872c19b8e in prompt
>         (/download/dpdk/install/bin/dpdk-testpmd+0x458b8e)
>     #9 0x55a872be425a in main
>         (/download/dpdk/install/bin/dpdk-testpmd+0x42325a)
>     #10 0x7f7538756d8f in __libc_start_call_main
>         ../sysdeps/nptl/libc_start_call_main.h:58
>=20
> This patch addresses that by registering all queue_job structs, for a
> given queue, on a linked list. Whenever operation results are pulled
> and result is handled, queue_job struct will be removed from that list
> and freed.
> Before port is closed, during flow flush, testpmd will pull
> all of the expected results
> (based on the number of queue_job on the list).
>=20
> Fixes: c9dc03840873 ("ethdev: add indirect action async query")
> Fixes: 99231e480b69 ("ethdev: add template table resize")
> Fixes: 77e7939acf1f ("app/testpmd: add flow rule update command")
> Fixes: 3e3edab530a1 ("ethdev: add flow quota")
> Fixes: 966eb55e9a00 ("ethdev: add queue-based API to report aged flow rul=
es")
> Cc: stable@dpdk.org
>=20

Surprisingly AI code spotted a minor bug which I did not see.


---

## DPDK Patch Evaluation: `app/testpmd: fix flow queue job leaks`

### Summary

| Category | Status |
|----------|--------|
| Commit Message | =E2=9C=85 Pass |
| Tags | =E2=9C=85 Pass |
| Code Style | =E2=9A=A0=EF=B8=8F Minor issues |
| Code Correctness | =E2=9D=8C **Bug found** |

---

### Commit Message Analysis

**Subject Line:** `app/testpmd: fix flow queue job leaks`

| Criterion | Result |
|-----------|--------|
| Length (=E2=89=A460 chars) | =E2=9C=85 37 characters |
| Format `component: description` | =E2=9C=85 Correct |
| Component prefix | =E2=9C=85 `app/testpmd:` (not `testpmd:`) |
| Lowercase after colon | =E2=9C=85 Yes |
| Imperative mood | =E2=9C=85 "fix" |
| No trailing period | =E2=9C=85 Correct |
| No forbidden punctuation | =E2=9C=85 Clean |

**Body:**
- =E2=9C=85 Does not start with "It"
- =E2=9C=85 Provides clear context (ASAN leak report, explanation of queue_=
job lifecycle)
- =E2=9C=85 Lines appear within 75 character limit
- =E2=9C=85 Well-structured explanation of the problem and solution

**Tags:**
- =E2=9C=85 Multiple `Fixes:` tags with 12-character SHAs and quoted subjec=
ts
- =E2=9C=85 `Cc: stable@dpdk.org` present (appropriate for bug fix)
- =E2=9C=85 `Signed-off-by:` with real name and valid email
- =E2=9C=85 Tag order correct: Fixes =E2=86=92 Cc =E2=86=92 blank line =E2=
=86=92 Signed-off-by

---

### Code Style Analysis

**Positive:**
- =E2=9C=85 Function return types on separate lines
- =E2=9C=85 Explicit comparisons (`res =3D=3D NULL`, `ret < 0`, `ret =3D=3D=
 0`)
- =E2=9C=85 Proper brace style (single statements without braces)
- =E2=9C=85 Lowercase function names with underscores
- =E2=9C=85 Comment style follows guidelines
- =E2=9C=85 Lines within 100 characters

**Info (minor observations):**
- C99-style loop variable declarations (`for (int i =3D 0; ...)` and `for (=
queueid_t queue_id =3D 0; ...)`). This is acceptable in DPDK but some maint=
ainers prefer traditional style.

---

### =E2=9D=8C Critical Bug Found: Format String Argument Mismatch

There are **two printf format string bugs** where arguments are in the wron=
g order:

**Bug 1 (line ~428-429):**
```c
printf("Flushed flow queue %u on port %u (%u failed, %u succeeded).\n",
       port_id, queue_id, polled - success, success);
```
Format says "queue %u on port %u" but arguments are `port_id, queue_id` =E2=
=80=94 **reversed**.

**Bug 2 (line ~437-438):**
```c
TESTPMD_LOG(ERR, "Unable to fully flush flow queue %u on port %u (left ops =
%u)\n",
            port_id, queue_id, expected_ops);
```
Same issue =E2=80=94 format expects queue then port, but arguments are port=
 then queue.

**Correct version should be:**
```c
printf("Flushed flow queue %u on port %u (%u failed, %u succeeded).\n",
       queue_id, port_id, polled - success, success);

TESTPMD_LOG(ERR, "Unable to fully flush flow queue %u on port %u (left ops =
%u)\n",
            queue_id, port_id, expected_ops);
```

Note: Line ~475-476 has the correct order (`queue_id, port_id`), which make=
s this inconsistency more apparent.

---

### Verdict

| Severity | Issue |
|----------|-------|
| **Error** | Format string argument order bug (2 instances) =E2=80=94 will=
 print misleading debug output |
| Info | C99 loop variable declarations |

**Recommendation:** Request v3 to fix the printf argument order. The fix it=
self is sound in design =E2=80=94 tracking queue_job entries on a list and =
flushing on port close is the right approach. The ASAN leak is properly add=
ressed. However, the swapped format arguments would cause confusing output =
during debugging ("Flushed flow queue 0 on port 1" when it should say "queu=
e 1 on port 0").

