Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5A6D4A605
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 06:54:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CADA410D2;
	Fri, 16 Jan 2026 07:54:02 +0100 (CET)
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65]) by mails.dpdk.org (Postfix) with ESMTP id D64BD4060F
 for <dev@dpdk.org>; Fri, 16 Jan 2026 07:54:01 +0100 (CET)
Received: by mail-ej1-f65.google.com with SMTP id
 a640c23a62f3a-b8765b7f4c0so284177066b.0
 for <dev@dpdk.org>; Thu, 15 Jan 2026 22:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768546441;
 x=1769151241; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jmyWBAvmqaT48v/fIGEe76XxnQJtPSd7J3feDkH7SOI=;
 b=RFrZkWfG778t6HhtdHZVxQrXTjYYNpnYodDxkS2ANOsh07wbyu+ymFKhipDbDzenC8
 FMYE6Xj27Oi6NnG8TiCKQOu8i+PQ5sVO4rK75zUGOZtcJiU1Wqfr8oXs8v3MGE/lPbDh
 k9Fk1xpfmlmZZg/aE0M/hrBi1kXODR8UhALG05hcsI1oElQVkwQI4ZJf4Opa0970dVnw
 C5O9syXBRYdlpCu6BM1CVT9Awqoldj7TPn4deRZaRYpidV6PTQD+C/yOXPNNCWTRKryE
 R2fZ8izf1isD0qn50uXTgGNhOpO9XRiFqSNCnXT1/dIyyXLLw1eBY966IICVzEwPovTh
 z7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768546441; x=1769151241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jmyWBAvmqaT48v/fIGEe76XxnQJtPSd7J3feDkH7SOI=;
 b=RquPUo6Gc+tY6qbizVgOCvZ+ummqumsHZUrwv3WPxngv6T6/5pZqge8I6ZqXBsjvkL
 NUr//dPId2Mi+Ng4qk/F+itbkw6qGp4eMHClQJNTMWIr0pW7GAaP3re1zTvCdDHZ5zm0
 ha/2XkQAjQe+KWWYhQMrRQLDwxmLdyg+3f9Az5/gNQEPyzZZy1TO7vQNxVFgVUOHlQOo
 /27CFpZHXlsGAdS37naQlHvHekvmuPoYFYI7wB2tEtUhMo6XIw9tuheBdcLpU4GTvTa6
 BJauIzoZkbyMghdQtyK232WJz9hFLtM6/3TIUyZwT3XtpBLmgos9jpekANUu7va14oRa
 wasQ==
X-Gm-Message-State: AOJu0YzrQO7rhqq2qcauslP1EZo7kIWXVJ5zFGSboPYkFeBd/y5v6Xf0
 EfZATiPrLx83xtLM6/uhpSYSRnQIuUiIZJKC2HcE6Q7aSgIrSY8fiDZQNnB5uwznj1s=
X-Gm-Gg: AY/fxX7ZUo/9l3sez/QWSWfpD+Axk8dyC6Pg9cTmliFkkpWy+JG0I+OZ+/iaupfI6/2
 NiI3PWIZmi9xRZWeSkq0zR0RbXqgIN6ywKhz2AASC61v4fz0neism17tb4naLrDDj1mMss1DEKZ
 IWlAJIhHPqIqdrXefqJ9lUlEpUjY3QTP2zEP4DkxPLerPgA5xMe/vxezjSLfM0grHJ2VXZynxiI
 BGB8/At+evRhE27UiOMHyeWXu1WUZSTHGa1a7bvoEGuWjnVTvnhf+VURfjPz9EPzGltHPzv4MOB
 c5adTFHNwSXCAUcSOHwFNP6BTiBXS88AO/T1/WjrGEOYMTqQOk5D8J6+CzmgRlC3EvPj7RORC5F
 JqB1MDoO0Y860mA1af84mxNXvUPpKvtXxsQm5Pq5iTnVmTn8Lv2KBJ0/fVCiPB155lBSPDQ6ANG
 jXM5dyytLyatuujda/JtcYcjZlukzcS2913Dv4EVL9aedI4OQuFO/0uKeLhLtllW0=
X-Received: by 2002:a17:907:8e96:b0:b87:33f3:605b with SMTP id
 a640c23a62f3a-b8792f3b19cmr177737466b.27.1768546441314; 
 Thu, 15 Jan 2026 22:54:01 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm142089466b.36.2026.01.15.22.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 22:54:01 -0800 (PST)
Date: Thu, 15 Jan 2026 22:53:54 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/7] Add script for real-time telemetry monitoring
Message-ID: <20260115225354.4963d25f@phoenix.local>
In-Reply-To: <20260115190331.3721281-1-bruce.richardson@intel.com>
References: <20251210165532.103450-1-bruce.richardson@intel.com>
 <20260115190331.3721281-1-bruce.richardson@intel.com>
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

On Thu, 15 Jan 2026 19:03:24 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> TL;DR
> ------
>=20
> For a  quick demo, apply patches, run e.g. testpmd and then in a separate
> terminal run:
>=20
>   ./usertools/dpdk-telemetry-watcher.py -d1T eth.tx
>=20
> Output, updated once per second, will be traffic rate per port e.g.:
>=20
> Connected to application: "dpdk-testpmd"
> Time       /ethdev/stats,0.opackets /ethdev/stats,1.opackets        Total
> 16:29:12                  5,213,119                5,214,304   10,427,423
>=20
>=20
> Fuller details
> --------------
>=20
> While we have the dpdk-telemetry.py CLI app for interactive querying of
> telemetry on the commandline, and a telemetry exporter script for
> sending telemetry to external tools for real-time monitoring, we don't
> have an app that can print real-time stats for DPDK apps on the
> terminal. This patchset adds such a script, developed with the help of
> Github copilot to fill a need that I found in my testing. Submitting it
> here in the hopes that others find it of use.
>=20
> The script acts as a wrapper around the existing dpdk-telemetry.py
> script, and pipes the commands to that script and reads the responses,
> querying it once per second. It takes a number of flag parameters, such
> as the ones above:
>  - "-d" for delta values, i.e. PPS rather than total packets
>  - "-1" for single-line output, i.e. no scrolling up the screen
>  - "-T" to display a total column
>=20
> Other flag parameters can be seen by looking at the help output.
>=20
> Beyond the flags, the script also takes a number of positional
> parameters, which refer to specific stats to display. These stats must
> be numeric values, and should take the form of the telemetry command to
> send, followed by a "." and the stat within the result which is to be
> tracked. As above, a stat would be e.g. "/ethdev/stats,0.opackets",
> where we send "/ethdev/stats,0" to telemetry and extract the "opackets"
> part of the result.
>=20
> However, specifying individual stats can be awkward, so some shortcuts
> are provided too for the common case of monitoring ethernet ports. Any
> positional arg starting with "eth" will be replaced by the set of
> equivalent values for each port, e.g. "eth.imissed" will track the
> imissed value on all ports in use in the app. The ipackets and opackets
> values, as common metrics, are also available as shortened values as
> just "rx" and "tx", so in the example above, "eth.tx" means to track the
> opackets stat for every ethdev port.
>=20
> Finally, the script also has reconnection support so you can leave it
> running while you start and stop your application in another terminal.
> The watcher will try and reconnect to a running instance every second.
>=20
> v3:
> Updated following AI review
> - removed unnecessary f-string
> - added documnentation in guides/tools
> - added release note entry
>=20
> v2:
> - improve reconnection handling, eliminating some crashes seen in testing.
>=20
>=20
> Bruce Richardson (7):
>   usertools: add new script to monitor telemetry on terminal
>   usertools/telemetry-watcher: add displaying stats
>   usertools/telemetry-watcher: add delta and timeout opts
>   usertools/telemetry-watcher: add total and one-line opts
>   usertools/telemetry-watcher: add thousands separator
>   usertools/telemetry-watcher: add eth name shortcuts
>   usertools/telemetry-watcher: support reconnection
>=20
>  doc/guides/rel_notes/release_26_03.rst |   7 +
>  doc/guides/tools/index.rst             |   1 +
>  doc/guides/tools/telemetrywatcher.rst  | 184 +++++++++++
>  usertools/dpdk-telemetry-watcher.py    | 435 +++++++++++++++++++++++++
>  usertools/meson.build                  |   1 +
>  5 files changed, 628 insertions(+)
>  create mode 100644 doc/guides/tools/telemetrywatcher.rst
>  create mode 100755 usertools/dpdk-telemetry-watcher.py

Automated AI review of this patch series.
Yes AI seems to be pickier about python code (wonder what it is trained on?)


---

## DPDK Patch Review: Telemetry Watcher (v3, 7 patches)

**Series**: `[PATCH v3 1/7]` through `[PATCH v3 7/7]` =20
**Author**: Bruce Richardson <bruce.richardson@intel.com> =20
**Reviewed against**: AGENTS.md review criteria

---

### Summary

| Category | Status |
|----------|--------|
| Commit Messages | =E2=9C=93 Pass |
| SPDX/License | =E2=9A=A0 Warning (minor) |
| Code Style | =E2=9A=A0 Warning (minor) |
| Documentation | =E2=9C=93 Pass |
| Release Notes | =E2=9C=93 Pass |
| Build Integration | =E2=9C=93 Pass |

---

### Commit Message Review

**All 7 patches pass commit message requirements:**

| Patch | Subject | Length | Format |
|-------|---------|--------|--------|
| 1/7 | `usertools: add new script to monitor telemetry on terminal` | 52 c=
hars | =E2=9C=93 |
| 2/7 | `usertools/telemetry-watcher: add displaying stats` | 47 chars | =
=E2=9C=93 |
| 3/7 | `usertools/telemetry-watcher: add delta and timeout opts` | 53 char=
s | =E2=9C=93 |
| 4/7 | `usertools/telemetry-watcher: add total and one-line opts` | 55 cha=
rs | =E2=9C=93 |
| 5/7 | `usertools/telemetry-watcher: add thousands separator` | 51 chars |=
 =E2=9C=93 |
| 6/7 | `usertools/telemetry-watcher: add eth name shortcuts` | 51 chars | =
=E2=9C=93 |
| 7/7 | `usertools/telemetry-watcher: support reconnection` | 49 chars | =
=E2=9C=93 |

- =E2=9C=93 All subjects =E2=89=A460 characters
- =E2=9C=93 Lowercase after colon (except acronyms)
- =E2=9C=93 Imperative mood
- =E2=9C=93 No trailing periods
- =E2=9C=93 `Signed-off-by:` present with valid name/email
- =E2=9C=93 `Acked-by:` present (your ack is included)
- =E2=9C=93 Body lines appear wrapped at 75 characters
- =E2=9C=93 Body does not start with "It"

---

### License/SPDX Review

**Python script** (`dpdk-telemetry-watcher.py`):
```python
#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-3-Clause
# Copyright(c) 2025 Intel Corporation
```
=E2=9C=93 SPDX on line 2 (correct for shebang scripts) =20
=E2=9C=93 Copyright follows immediately =20
=E2=9C=93 Blank line before code =20
=E2=9C=93 BSD-3-Clause (appropriate for usertools)

**Documentation** (`telemetrywatcher.rst`):
```rst
..  SPDX-License-Identifier: BSD-3-Clause
    Copyright(c) 2026 Intel Corporation
```
=E2=9C=93 SPDX on first line =20
=E2=9C=93 Copyright follows =20

=E2=9A=A0 **Warning**: Copyright year mismatch =E2=80=94 Python script says=
 **2025**, documentation says **2026**. Should be consistent (likely both s=
hould be 2025 or 2026 depending on when work started).

---

### Code Style Review

**Patch 5** (thousands separator):

=E2=9A=A0 **Warning**: The patch adds `import locale` and uses `f"{display_=
value:n}"` for locale-aware number formatting, but **does not call `locale.=
setlocale(locale.LC_ALL, '')`** to activate locale-aware formatting. Withou=
t this call, the `:n` format specifier may not produce thousands separators=
 on all systems.

**Suggested fix** =E2=80=94 add to `main()`:
```python
import locale
locale.setlocale(locale.LC_ALL, '')
```

**Patch 6** (eth shortcuts):

=E2=9A=A0 **Info** (minor): Unnecessary f-string at line 1401:
```python
print(f"Error: Failed to get ethernet device list", file=3Dsys.stderr)
```
Should be:
```python
print("Error: Failed to get ethernet device list", file=3Dsys.stderr)
```

**General Python style**:
- =E2=9C=93 Good docstrings throughout
- =E2=9C=93 Consistent formatting (appears black-compliant)
- =E2=9C=93 Line lengths within 100 characters
- =E2=9C=93 Good error handling with informative messages

---

### Documentation Review

=E2=9C=93 **Comprehensive documentation** in `telemetrywatcher.rst`:
- Application description
- Command-line options documented
- Statistics format explained
- Shortcuts documented
- Multiple usage examples
- Dependencies listed
- Output format described

=E2=9C=93 **Documentation matches code behavior**

=E2=9C=93 **Index updated** in `doc/guides/tools/index.rst`

---

### Release Notes Review

=E2=9C=93 **Release notes added** in patch 7/7 (`doc/guides/rel_notes/relea=
se_26_03.rst`):
```rst
* **Added Script for Real-time Telemetry Monitoring.**

  Introduced the `dpdk-telemetry-watcher.py` script, enabling users to moni=
tor
  real-time telemetry statistics from running DPDK applications.
  The tool supports customizable display options, including delta values,
  total statistics, and single-line output for compact monitoring.
```

=E2=9C=93 Appropriate placement =E2=80=94 release notes in final patch when=
 feature is complete

---

### Build Integration Review

=E2=9C=93 **meson.build updated** (patch 1/7):
```python
install_data([
    ...
    'dpdk-telemetry-watcher.py',
],
install_dir: 'bin')
```

---

### Structural Review

=E2=9C=93 Each patch appears independently functional (incremental developm=
ent) =20
=E2=9C=93 Code and documentation updated together in relevant patches =20
=E2=9C=93 No forward dependencies within patchset =20

**Note**: No automated tests added for this usertools script. This is commo=
n practice for Python usertools in DPDK, though the `black` formatter shoul=
d be run on the code.

---

### Issues Summary

| Severity | Issue | Location |
|----------|-------|----------|
| **Warning** | Copyright year mismatch (2025 vs 2026) | Python script vs R=
ST doc |
| **Warning** | Missing `locale.setlocale()` call for `:n` format | Patch 5=
/7 |
| **Info** | Unnecessary f-string | Patch 6/7, line with "Failed to get eth=
ernet device list" |

---

### Recommendation

**Acceptable with minor fixes**. The patch series is well-structured, prope=
rly documented, and follows DPDK conventions. The two warnings should be ad=
dressed:

1. Harmonize copyright years
2. Add `locale.setlocale(locale.LC_ALL, '')` to ensure thousands separators=
 work correctly
