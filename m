Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CB2D2502E
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 02:58:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDA4C4028F;
	Mon, 12 Jan 2026 03:58:18 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id BEA2B4013F
 for <dev@dpdk.org>; Mon, 12 Jan 2026 03:58:17 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so40791115e9.0
 for <dev@dpdk.org>; Sun, 11 Jan 2026 18:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768186697;
 x=1768791497; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4fhfKEbo3rXVVGwMVRFd/wW9ToDaToLIgvho/NneqsY=;
 b=OyFksh1/4EM9eF+h3zC9Ub8gShLaBXvblwV7HVxz+1z2fo0WZNqVvB1vxAr9dMzZsT
 +4OAOD92+ZMYGB5xrt0umg7QV4wIqKC9c+VL5RSYlrfatbow2P/eb5vgJbLdo4DxHO6h
 ZvpK2/BJbvw5cFwY6RqYg2mqqN91UcFXvOZ7eemAXWgByVLSr2t5ysGkFgk0fMHUWPxH
 HniLwPJ800Xl3IOh30zhEKQj2nYsCXzscy/VnLO2aUYifCyCctmTfqz+iB/zBy3JRSEj
 6aMpU/2lj73xdIlgr41NI93Y31cyQcjrzbRIjO2wmowWUVyYvgAkLDnh/LbbN8I/GGTz
 bWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768186697; x=1768791497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4fhfKEbo3rXVVGwMVRFd/wW9ToDaToLIgvho/NneqsY=;
 b=HxD/fc4z5rrs5rOgY+UfoacHuoOoiT+IVqKOVJSLYzMVwPDs2J5xvl04WUo2kLtwY7
 H3sb71VxquVnXjPg5iP1KccY9Xyru4OqPl0pNTqXC4tsihfwYjZ+GXWfIuEuXH5OO0vU
 aQ1N6dvB0n+wG/jMJLc7xKWAJn5YCs3uvYHCtSeZl10mZiTTJdyoObkTErpisGmVuC3k
 BxCUBx6Y9QkXzL0HSKdIONm1auve/ENXY7o/3mXBaic5nutJiVbAYBUwrPuCZrs9UR03
 IcV0bAsZtSqy0qRao7SIXgXqdwndIbFfhGhQTln74tdCgS3/I322RTIecFPYEthZnl3m
 CNKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKJpvXYClHpXtPzgFzIszes9ydid8GRUhI1EBZsLHnhH2lFdKJXYfHZri60NSN4A3b9q4=@dpdk.org
X-Gm-Message-State: AOJu0Yx0cNtxgZptl+VLW27YHO4l7Qx/snz1cqkxupb/+u0WlcGqUYTS
 WGF3hjkt08rYYNrdIa92Dm0/ONKiXGJE5MMSQBkF+p8QYrfx9m87JIU/JmRQr8nTTFw=
X-Gm-Gg: AY/fxX69B7uGIGPysEoAnfRILgKO+CFQVPEzp+/v+QuURN7c4pI18/ZZDO607Eewmp3
 YBEDMI3t7uYzGPdiimnpEmTDXAiYSuq492pwhrbIx9CACPcCKftBBepjfyMWYhIDK/z5Z7n7ACO
 xhuWv4+0MKGUwbj5aaRfW5Ek7+KN1ZLa3VTsKsjTb6ipKNQld0B3rh7OJWTuWJBSfDvsADZUhOi
 FQcAdP+PB7LqMTMZb6QcE17jhfmSP3704k0Ic9AQe0VSyWBbZC3367J1i1pRmKTRwDIcNjBi533
 +mxgRtPUibkJJME1yFBhtE+sJS+ZwNwxgTvT0aAKb8Fj9DLNw9gj1cTCotd+CWrqlKbTcHASjhc
 GRPlw838BE3i7CReo1ybqFihjwqx8eGt+mR/t9Q/xHbZPx/50BaGuzl4SgY99QEM2RWMP0gOY0S
 MW3++dHTzJ/Y/yg//mK4L6s2RCP7KubPaLGKH/fkWZyc3rTP93uqaK
X-Google-Smtp-Source: AGHT+IFPjtHAJlkluA2CI3Lp5Q/EOie4Dxkgz9u3IWnI9BGUtkoA3EPNp26/9uNP8kOXHYH8ff3q5g==
X-Received: by 2002:a05:600c:3542:b0:46e:32dd:1b1a with SMTP id
 5b1f17b1804b1-47d84b26bf0mr164713435e9.7.1768186697086; 
 Sun, 11 Jan 2026 18:58:17 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8662ffaasm119596955e9.6.2026.01.11.18.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 18:58:16 -0800 (PST)
Date: Sun, 11 Jan 2026 18:58:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Madhuker Mythri <madhukar.mythri@gmail.com>
Cc: longli@microsoft.com, dev@dpdk.org, madhuker.mythri@oracle.com
Subject: Re: [PATCH] net/netvsc: Fix on race condition of multiple commands
Message-ID: <20260111185809.47d9f7a7@phoenix.local>
In-Reply-To: <20251212115238.59710-1-madhukar.mythri@gmail.com>
References: <20251212115238.59710-1-madhukar.mythri@gmail.com>
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

On Fri, 12 Dec 2025 17:22:38 +0530
Madhuker Mythri <madhukar.mythri@gmail.com> wrote:

> When multiple processes issue command requests(like: device info get
> and link-status) at same-time, then we could see the command request
> failures, due to race-condition of common function execution.
>=20
> So, to avoid such race-condition introduced a new spin-lock to protect
> the code of critical section.
>=20
> Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")
> Signed-off-by: Madhuker Mythri <madhukar.mythri@gmail.com>

AI patch review spotted some minor things and raises vaild question
about overall races in hn_rndis_exec

## Patch Review: net/netvsc Race Condition Fix

Based on the AGENTS.md DPDK review criteria, here's my assessment:

---

### **ERRORS (Must Fix)**

1. **Subject line capitalization** =E2=80=94 "Fix" should be lowercase "fix"
   - Current: `net/netvsc: Fix on race condition of multiple commands`
   - Should be: `net/netvsc: fix race condition in multiple commands`

2. **Missing blank line before Signed-off-by** =E2=80=94 Per tag order requ=
irements, there must be a blank line between the `Fixes:` block and the `Si=
gned-off-by:` block:
   ```
   Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")

   Signed-off-by: Madhuker Mythri <madhukar.mythri@gmail.com>
   ```

---

### **WARNINGS (Should Fix)**

1. **Awkward grammar in subject** =E2=80=94 "Fix on race condition" is gram=
matically incorrect. Should be "fix race condition" (removing "on").

2. **Missing `Cc: stable@dpdk.org`** =E2=80=94 This is a bug fix with a `Fi=
xes:` tag, so it's a candidate for stable backport.

3. **Body formatting nit** =E2=80=94 Line 89 has `requests(like:` =E2=80=94=
 missing space before the parenthesis. Should be `requests (like:`.

4. **Incomplete protection?** =E2=80=94 The spinlock only wraps `hn_rndis_e=
xecute()` inside `hn_rndis_query()`, but `hn_rndis_execute()` is likely cal=
led from other paths (e.g., `hn_rndis_set()`). If the race condition is in =
`hn_rndis_execute()` itself, all callers should be protected =E2=80=94 or t=
he lock should be inside `hn_rndis_execute()` rather than in `hn_rndis_quer=
y()`.

---

### **INFO (Minor/Consider)**

1. **Commit body could be clearer** =E2=80=94 Consider specifying which exa=
ct functions race (e.g., "concurrent calls to `hn_rndis_query()` from diffe=
rent control paths can corrupt the shared response buffer").

2. **Lock granularity** =E2=80=94 Holding a spinlock across `hn_rndis_execu=
te()` which appears to wait for completion could block other threads for ex=
tended periods. A mutex might be more appropriate if this isn't a fast-path=
 operation.

---

### **What's Correct** =E2=9C=93

- Subject length (53 chars =E2=89=A4 60)
- Correct component prefix (`net/netvsc:`)
- Imperative mood
- No trailing period
- Body lines within 75 characters
- Body doesn't start with "It"
- `Signed-off-by:` present with real name and email
- `Fixes:` tag present with 12-char SHA and quoted subject
- Code uses proper DPDK APIs (`rte_spinlock_*`)
- Code changes are minimal and focused

---

### **Suggested Revised Commit Message**

```
net/netvsc: fix race condition in RNDIS command execution

When multiple threads issue RNDIS command requests (such as device
info queries and link status checks) simultaneously, command failures
can occur due to concurrent access to shared resources in the RNDIS
execution path.

Add a spinlock to serialize RNDIS command execution and prevent
data corruption.

Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")
Cc: stable@dpdk.org

Signed-off-by: Madhuker Mythri <madhukar.mythri@gmail.com>
```

---

### **Technical Question for Author**

Is `hn_rndis_query()` the only caller of `hn_rndis_execute()` that can race=
, or should `hn_rndis_set()` and other callers also be protected? If the ra=
ce is in the execute function itself, moving the lock inside `hn_rndis_exec=
ute()` would provide complete protection.
