Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B70EB362C
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 19:31:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDB5740A76;
	Mon,  2 Mar 2026 20:31:56 +0100 (CET)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by mails.dpdk.org (Postfix) with ESMTP id 83EA04028C
 for <dev@dpdk.org>; Mon,  2 Mar 2026 20:31:55 +0100 (CET)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1275750cfc7so955568c88.0
 for <dev@dpdk.org>; Mon, 02 Mar 2026 11:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772479914;
 x=1773084714; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:subject:cc:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V+hMlH6nds2LDCe8c4KL00LY6v+UnEi0M8SCMah+I5I=;
 b=pS8SEOo2HqmcLrmuDoAI1S0eiqGUteta3P5Eq1Ab9vc3bwTFNxI32BLwj2xswt/iTj
 EkZb3barZ59J9WRmzxk/OOQP8C01GoZQIiqPwL6gFN04fAKh2dxGijlLpFtlTaCAchFK
 a+VAM6EPlvLbiI3o/MLmDTZ7P2lWsneNycZOOhg3W9aBZ9Ob70rCvWL+k8Wg/kJ0a727
 fCjyed21LYgRb+0w56aXuW+MqNGCf9hXnXy3CS8I1bgDSo5R6yHHCLF+yl4bPzTGBMRX
 qPqeTyk4c+r798X4qHHdOoSmMzvXLrervq+Mi6ndr482jCFpuaFaaPpe0IB8SzyKhHGP
 vXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772479914; x=1773084714;
 h=content-transfer-encoding:mime-version:message-id:subject:cc:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V+hMlH6nds2LDCe8c4KL00LY6v+UnEi0M8SCMah+I5I=;
 b=IFKgucNgmRx/4ZeJgs3WwJ3mkhU/XRtVHu11FxN1BHBrL5wIaDo6jBqp01Gmac6R4n
 gY8hUAHw0LLufKOuJ4W9mil3tvZmi8RI+6lfxSTqanX1A4ZuFkMYDcgESTGopcUPaT9n
 oPHAWVwkke6O2awJXagfzeirtfTiHIUoYkzM9zwXuuv8T/hUrPuclisYnFBGCH9R2v/9
 0F/Hkdr9sitd1XVEGzdV7hj79VzpacaxaxkTcUhDHwmuIJBHQw07Gy1e5CtTZJhOwgN1
 634kxmd5z+CduH6djphNMBrWHnSuIxiPXk9n5gTx2ymbX5YatK5EifAREsDbNh3yt7yI
 6LAw==
X-Gm-Message-State: AOJu0YwcEu1TWLmJRmV9w3yQLQ6Sxi0h3WYU05thQgOshb6u/XwtjUIo
 B072y6xL5UbS9H1sT9ZdQTsnUJ+s8SEvxcIpUHiiiwqLywvftYaqhMB/vpTo4rnlk1I=
X-Gm-Gg: ATEYQzyVoviHfGKGYr6r+PqEHFxcpRfdzCkfCSF9bPw2C2JuxZowWoC+8JXptCPhBx1
 KzFmJvUmrdCjCVC7nqt8+gQyUtbDvKxTCEDaeUQSYUbXTPW9Lsssbnb2ZMo01EnArgKrvPpk4iI
 WT8pEBgXMDvvd/Y5Gb3aaqwhMn1KzRxjkAYuxD9jedEY4ruucgfyR24Yfx5uvNe9/t1SdN/Lcqp
 8VuAXvC/+gfeVjuLOV3AH4NTKrJrU9hapqADCW477qOhSEJ2dzK04PAT2YmLKeNpvXP2na9RxC+
 d81DkG7vjGvllbZnbrSjQr7yGb4Ty/Bs09ekATI5RcWn8Evg8upJJh6+IkgdyMIcqusEv91YYwu
 xA5oSgx1m1UtddkOonmEh/ZH27sFdiovbX4oX3catkGi03YyKbDaPKOOG9IFfRTimM9rNR3xv4R
 z6mhCfSbiOjVEJ1rhiZphfQW5xHTyqc/euQ7L/joUa5WEPsVMK7oKO6TrI8IqVm+4Q
X-Received: by 2002:a05:7022:421:b0:124:11af:7b75 with SMTP id
 a92af1059eb24-1278fd21ac1mr6312756c88.34.1772479914174; 
 Mon, 02 Mar 2026 11:31:54 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-127899d49c1sm19987179c88.1.2026.03.02.11.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 11:31:53 -0800 (PST)
Date: Mon, 2 Mar 2026 11:31:50 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ori Kam <orika@nvidia.com>
Cc: dev@dpdk.org
Subject: Bug analysis of regexdev library
Message-ID: <20260302113150.61c9c150@phoenix.local>
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

Since nobody uses it, thought I would test AI review of regexdev library.

It found many things, and not to mention there are no regression tests for =
the library.
Is anyone using or maintaining this? Can it be deprecated in 26.07 and remo=
ved in 26.11?

Here's a thorough bug analysis of the DPDK regexdev library:

## Critical Bugs

**1. Wrong comparison operator in `rte_regexdev_get_dev_id()`** (`rte_regex=
dev.c`)

This is the most serious bug. The function uses `strcmp()` without negation=
, so it matches on names that are *different* rather than equal:

```c
if (strcmp(name, rte_regex_devices[i].data->dev_name)) {
    id =3D rte_regex_devices[i].data->dev_id;
    break;
}
```

`strcmp()` returns 0 (falsy) on match. This should be `!strcmp(...)` or `st=
rcmp(...) =3D=3D 0`, exactly as done correctly in `regexdev_allocated()`. A=
s written, this returns the ID of the first device whose name *doesn't* mat=
ch.

**2. Wrong `memset` value on re-registration** (`rte_regexdev.c`, `rte_rege=
xdev_register()`)

```c
if (dev->data =3D=3D NULL)
    dev->data =3D &rte_regexdev_shared_data->data[dev_id];
else
    memset(dev->data, 1, sizeof(*dev->data));
```

The `else` branch fills the data structure with byte value `1` (0x01 repeat=
ing), not zero. This is almost certainly meant to be `memset(dev->data, 0, =
...)`. A fill value of `1` corrupts every field: `dev_id` becomes garbage, =
`dev_name` becomes non-NUL junk, `dev_started` becomes 1 (true), etc. The `=
if` branch also has a problem =E2=80=94 newly assigned data from the shared=
 array is never zeroed, so it relies on the one-time `memset` in `regexdev_=
shared_data_prepare()`.

**3. `rte_regexdev_stop()` ignores driver return value** (`rte_regexdev.c`)

```c
dev->dev_ops->dev_stop(dev);
dev->data->dev_started =3D 0;
return 0;
```

The `dev_stop` callback returns `int`, but the return value is discarded. I=
f the driver fails to stop, the library unconditionally marks the device as=
 stopped and returns success. Compare with `dev_start`, which correctly che=
cks the return value before updating state.

## Moderate Bugs

**4. `rte_regexdev_close()` doesn't check driver return** (`rte_regexdev.c`)

Same pattern as stop =E2=80=94 `dev_close()` return is ignored, and the dev=
ice is unconditionally marked `UNUSED` and `dev_started =3D 0` regardless o=
f whether the driver succeeded.

**5. Duplicate `dev_started` check in `rte_regexdev_queue_pair_setup()`** (=
`rte_regexdev.c`)

The `dev->data->dev_started` check appears twice, identically:

```c
if (dev->data->dev_started) {  // first check
    ...
    return -EBUSY;
}
if (queue_pair_id >=3D dev->data->dev_conf.nb_queue_pairs) {
    ...
}
if (dev->data->dev_started) {  // redundant duplicate
    ...
    return -EBUSY;
}
```

This is dead code =E2=80=94 the second check is unreachable unless there's =
a concurrent modification, and the library explicitly states it's not threa=
d-safe.

**6. `rte_regexdev_configure()` allows `nb_max_matches =3D=3D 0` despite do=
c** (`rte_regexdev.h` vs `.c`)

The header comment for `rte_regexdev_config::nb_max_matches` says "The valu=
e 0 is allowed, in which case, value 1 used." But the implementation explic=
itly rejects zero:

```c
if (cfg->nb_max_matches =3D=3D 0) {
    RTE_REGEXDEV_LOG_LINE(ERR, "Dev %u num of matches must be > 0", dev_id);
    return -EINVAL;
}
```

Either the doc or the code is wrong.

**7. Similarly, `nb_rules_per_group =3D=3D 0` rejection contradicts doc**

The header says "The value 0 is allowed, in which case, `max_rules_per_grou=
p` used." But the code rejects it with `-EINVAL`.

## Design / Robustness Issues

**8. `rte_regexdev_xstats_names_get()` rejects NULL but API says NULL retur=
ns capacity**

The header states: "If set to NULL, function returns required capacity." Bu=
t the implementation returns `-EINVAL` on NULL, making it impossible to que=
ry the required size.

**9. `rte_regexdev_xstats_reset()` rejects NULL `ids` but API says NULL res=
ets all**

The header says: "When NULL, all statistics will be reset." The implementat=
ion returns `-EINVAL` on NULL.

**10. Missing `#include <stdio.h>` dependency** (`rte_regexdev_core.h`)

The `regexdev_dump_t` typedef uses `FILE *f` but the header doesn't include=
 `<stdio.h>`. It works by accident through transitive includes, but it's te=
chnically a missing dependency.

**11. Type mismatch on `nb_rules`**

In `rte_regexdev.h`, `rte_regexdev_rule_db_update()` declares `nb_rules` as=
 `uint32_t`. In `rte_regexdev_core.h`, the callback typedef `regexdev_rule_=
db_update_t` declares it as `uint16_t`. This silently truncates rule counts=
 above 65535.

**12. `regexdev_capa` field is `uint32_t` but capability flags can exceed 3=
2 bits**

Capability `RTE_REGEXDEV_CAPA_QUEUE_PAIR_OOS_F` is defined as `(1ULL << 22)=
` with `ULL` suffix suggesting 64-bit intent, yet `struct rte_regexdev_info=
::regexdev_capa` is `uint32_t`. Currently the highest bit is 22, so it fits=
, but the `ULL` suffix signals the original developers may have intended a =
64-bit field, and any future flag at bit 32+ would be silently dropped.

---

The `strcmp` inversion (bug #1) and the `memset(..., 1, ...)` (bug #2) are =
the most impactful =E2=80=94 one breaks device lookup by name entirely, the=
 other corrupts device state on re-registration. The xstats NULL-handling m=
ismatches (#8, #9) and the `nb_rules` type mismatch (#11) are likely to bit=
e real driver consumers.
