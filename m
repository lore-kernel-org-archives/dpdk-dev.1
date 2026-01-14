Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05F6D31A0E
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 06:13:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9AF94028F;
	Wed, 14 Jan 2026 07:13:44 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 5A8F440289
 for <dev@dpdk.org>; Wed, 14 Jan 2026 07:13:43 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47ee2715254so2844875e9.3
 for <dev@dpdk.org>; Tue, 13 Jan 2026 22:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768371223;
 x=1768976023; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q1LeXDu55EhWY7JZFXOZoCCqWlUuz1ptB7Cjho77D3k=;
 b=AMcyDJvErBAkcDQZqtDPflYtmbnDz6y+0RpsHCZPsTfUrUewaTl+yQob3ea5uC9s1x
 Oc2wdCz0YSbaa+ekIeolbF27tcMGkLc+AnBsF+Drt+gZwLqNHSX94NZjFM3ZQQnZds32
 m0T+gn09ocYsOxDTWbhACqJ9CXQNjb9Sk62TBrhAs/kjl/OQfaF2Wem02Q+s+WIeFYxM
 INIv97CVOK+xFDOEwNeKc9CFb2rf7aHnP+E2iYtg6GjBe9tDKkgYz2MZxZDgVKcO86xp
 WDB8TTC5LlelZ9JO4njv5fq1CcrWqWmglwKeZuEb0iivrpB5/P7r9av1RsHOqacYARR8
 NGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768371223; x=1768976023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q1LeXDu55EhWY7JZFXOZoCCqWlUuz1ptB7Cjho77D3k=;
 b=QuiphF/sAOEc1CA9NOD6/fmQiKjAM7d2BRjV6AgrKURQbk7YYNllm7JO9ANKmeOHtq
 0lMVqktllfUJINV/nahtJ6BAgiHJr8eedK1VJBtcdMokYECwDYv7f7sPnm+qcCt7G9kz
 ReNdhvW4cgRaqi2i9VmUEFkHBhI0RymPnCRZqQ6FuC6ncItXibr7Qv1NMB8VN/mWHBFT
 mIj6DmkLsrz7KTpUCVVU9h2CS0h76ergqc7NyZYU3WsKGu2oPfzKSbIa34o/zLZsHQ0v
 Rkfwq0fFnl9IUc0G2hvb6L0/OHdoghzMgKHaJvkO8DrhKZ4vL9+wEPBvngaRnLEl76H0
 QDQw==
X-Gm-Message-State: AOJu0YxPT398weiTUGtQq5NBNQIgvafr+p3VJYpFjcmnfxRTBRmFcTYp
 1mzRTez4Jxb07/8ldc0X3O0PDN5MX4wkmkooDa8YEpAbt2HpIHKLVSh/V2afaHeGQdo=
X-Gm-Gg: AY/fxX5FMS9671mb4hvwwxghz4Q8GScKGjYp/boPKTD7X7nLgZ8Ne3zlRmWk1l1st0w
 qDRCs9l3PRtoAph6eqbyGEkVwksVolHfLKD3AEmqE7gFe+iGCzRNjG3rGmvmDoC+T2ZOf0aWKC7
 lkk+Y7UxJPefo9iEr57eWyB4F+tkxeb+s4/7JcT4Iy3VP1VJbigoFx3y2V2jHIzF63KeavEDlbg
 HLzHTh4r+EsHwF0cEpaIZc7vSL3vvdMc/VsWiYLjUNdJgtpYLKFYkHqXK0dODuCA0nS9s6F5JHX
 dVObcmZfsFSHjfq7iHK2SzLXCawWx6a+1SEv/blwSWIsigRFePO+NzRM8BwhBkPnKrwFflIpU+c
 sgm2Ei3anAMpbkr/Kya+DD1qIRuNBqe7j/v1cWs8iIK8Rc1YsBYkJM8iEtqwT0KshLvkzBvDbG0
 YCD12AmzoEfjSfsyCLFM4KxClU6qlx8jd8CMQzfWS5Ii0Em+Hk6OLS2n6hoGQQMrY=
X-Received: by 2002:a05:600c:828c:b0:477:aed0:f40a with SMTP id
 5b1f17b1804b1-47ee33641f3mr17030675e9.19.1768371222833; 
 Tue, 13 Jan 2026 22:13:42 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dacdcsm47557222f8f.1.2026.01.13.22.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 22:13:42 -0800 (PST)
Date: Tue, 13 Jan 2026 22:13:37 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: mamcgove@microsoft.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 1/1] examples/mp_server: warn on promisc enable failure
Message-ID: <20260113221337.5cbb0d92@phoenix.local>
In-Reply-To: <d7e617594063d3675636125ec9413ac4cbdc7e51.1758045692.git.mamcgove@microsoft.com>
References: <1747766224-31511-1-git-send-email-mamcgove@microsoft.com>
 <d7e617594063d3675636125ec9413ac4cbdc7e51.1758045692.git.mamcgove@microsoft.com>
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

On Tue, 16 Sep 2025 11:51:14 -0700
mamcgove@microsoft.com wrote:

> From: Matthew G McGovern <mamcgove@microsoft.com>
>=20
> Problem: Some devices do not allow promiscuous mode.
>=20
> Testpmd handles this by warning and ignoring failures from
> rte_eth_promiscuous_enable.
>=20
> Changes: make mp example apps warn if promiscuous mode cannot be
> enabled, rather than failing.
>=20
> Signed-off-by: Matthew G McGovern <mamcgove@microsoft.com>
>=20
> ---

AI review spotted a bug in this. Note, examples don't have to use RTE_LOG().
Only do so if other code in the example does.

## DPDK Patch Review: examples/mp_server: warn on promisc enable failure

### Summary

This patch changes promiscuous mode enable failure handling in two multi-pr=
ocess example applications from a fatal error to a warning, aligning behavi=
or with testpmd. While the intent is good, there's a **critical bug** in th=
e implementation.

---

### Critical Bug (Error - Must Fix)

**Wrong argument in fprintf format string** - Both changes print `retval` (=
the error code) where the port number should be:

```c
fprintf(stderr,
    "Error during enabling promiscuous mode for port %u: %s - ignore\n",
    retval, rte_strerror(-retval));
//  ^^^^^^ BUG: should be port_num (init.c) or port (main.c)
```

The `%u` format specifier expects the port number, but receives the negativ=
e error code. This will print nonsensical port numbers (e.g., "port 4294967=
287" for `-ENOTSUP`).

**Fix:**
```c
// In init.c:
fprintf(stderr,
    "Error during enabling promiscuous mode for port %u: %s - ignore\n",
    port_num, rte_strerror(-retval));

// In main.c:
fprintf(stderr,
    "Error during enabling promiscuous mode for port %u: %s - ignore\n",
    port, rte_strerror(-retval));
```

---

### Commit Message Review

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=93 | 49 characters |
| Lowercase after colon | =E2=9C=93 | |
| Imperative mood | =E2=9C=93 | "warn" is imperative |
| No trailing period | =E2=9C=93 | |
| Body wrapped at 75 chars | =E2=9C=93 | |
| Body doesn't start with "It" | =E2=9C=93 | |
| Signed-off-by present | =E2=9C=93 | |

**Warning: Subject prefix mismatch** - The subject says `examples/mp_server=
:` but the patch also modifies `examples/multi_process/symmetric_mp/main.c`=
. Consider using `examples/multi_process:` to accurately reflect the scope =
of changes.

---

### Code Style Review

| Check | Status |
|-------|--------|
| Line length =E2=89=A4100 chars | =E2=9C=93 |
| No trailing whitespace | =E2=9C=93 |
| Consistent with surrounding code | =E2=9C=93 |

---

### Design Considerations (Info)

1. **Consistency with testpmd**: The approach matches how testpmd handles t=
his, which is good for consistency across DPDK examples.

2. **Using fprintf vs RTE_LOG**: Example code commonly uses `fprintf(stderr=
, ...)` rather than `RTE_LOG()`, so this is acceptable style for examples.

3. **Message wording**: The "- ignore" suffix is slightly awkward. Consider=
: `"...port %u: %s (continuing anyway)\n"` or simply `"Warning: ..."`

---

### Verdict

**Changes Requested** - The patch has the right intent but contains a signi=
ficant bug that would produce incorrect/confusing output. After fixing the =
format string arguments, this should be straightforward to accept.
