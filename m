Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BE4D31A01
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 02:00:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92635402A7;
	Wed, 14 Jan 2026 03:00:53 +0100 (CET)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66]) by mails.dpdk.org (Postfix) with ESMTP id 32CDF4029D
 for <dev@dpdk.org>; Wed, 14 Jan 2026 03:00:52 +0100 (CET)
Received: by mail-wm1-f66.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so7127945e9.3
 for <dev@dpdk.org>; Tue, 13 Jan 2026 18:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768356052;
 x=1768960852; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=taxOpEWBMQXGcfUK21qZLOOqEhuj7I2Lqdh01XefTn0=;
 b=Z444Z3FakHo2BzVBITjRulYi7eIzAk9iC/N7DObJFGK6fziLefcuBIukuvZRjEBSwc
 1G0xvkZvWZPdXROLLKZrpvxWRXHCKFe7pLgQYfrCYhiOlaMt2m989xadTS+bgFfgoZe3
 hhpiEJMhIQ3Tsmlqs9PN9wPude92QZIBtclITCrHVRXimnHXL4AKa0Onf33pn41mttkl
 GAat2PyYHif5Y/DhXTTDOu8r33iIFQRv7UR5zmuh5bQGNnAqXMHiQEAwakhEdpjIHYfW
 D++xf8NJawLd5XIrhu3srVQK0rBA53jGm1E47AbY9SABEd0qcRegotBDeZ3tkvuD8Kbc
 SLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768356052; x=1768960852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=taxOpEWBMQXGcfUK21qZLOOqEhuj7I2Lqdh01XefTn0=;
 b=uF3PhtNc1LSrFXkfaerWSFSmDb2Q59SCeb9oAYykJ33QDNRDQJRYg//jMI5a+tN0+i
 WoeQEOnSpg0sov82ovgJhP//1UGyAzBuyCpBzPCcGCiBwURFJpMd4jsRSv7jszIcFvu4
 QqPTkZeaFJbVdNGEhOMJJ+tw0DSlBxCZ10VTzh7xv1d5W+5FiwhN4CD3sws1OSNNmYHW
 ZNRVK/3K7eLHAduAlwDIhn6gngvYJuqxG4LTJ97U0tIv7OswET9od0YnjyqLtq91tBV7
 dnPlNFlI/rfCNz86kYaDF3IjzzMqwp4iNKW5aVfFeCrQmZn/wLWerY0/F1sslT7cy0AO
 4p8A==
X-Gm-Message-State: AOJu0YxmvBRrVI1Le3YkVuggCN7uEQzf8wVFqJDXQAxSoDo4fVvSOJEA
 s62HilK4B8PHBWAl3ADJ6PJaw42M2/ocQ8hEdWv6huHIaBbwuCrgVz2ZmyB7zvl82Ps=
X-Gm-Gg: AY/fxX7Ln93We+tDusXThv6NhK/dxYAq6DBq2EIbtRxoCuovjCBuqj21DDsW22Pun/E
 zRphEf/kLHWBUo/RGB6r4nNpCtnDcrnqO6L/doirpDeNBK/CJ+zZyhoqThaSm95wx7WXRojEogq
 wm47YurFnKotYy01uWI77C3uFKN9mQSmEs03hRffYlf23Z+q/loOslTFJAO2Gte1gspfLgVCvgN
 DtebKuROdVchllngVUPBWJDf+Ffdj2ZwyKY+YOxSU6aMc+qikscpaqZsEnnYE617BHR9GzruTrV
 JoB6qOoF16jYFuuEn12fxhIJ5tqz3UbxwDV4pdeF08amPFD0V46GWA1AMMwu5FJtJuVB/yrAQKv
 pjbyDwnBT3ffXvrkehpO8gWKU2Az2SncuS7Vob9LyT8m6OgB0EtUJWJm9nr/D38zKarWpPYcAj7
 7ZL2PfnA9AknYyZzEnFVsyKHJJ/kWfPZhfjv0EHPsE6oB/DVJE5hhz
X-Received: by 2002:a05:600c:35c3:b0:47a:81b7:9a20 with SMTP id
 5b1f17b1804b1-47ee333b96bmr12946985e9.9.1768356051672; 
 Tue, 13 Jan 2026 18:00:51 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee563ce3csm3364395e9.14.2026.01.13.18.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 18:00:51 -0800 (PST)
Date: Tue, 13 Jan 2026 18:00:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/7] Add script for real-time telemetry monitoring
Message-ID: <20260113180046.2dab475d@phoenix.local>
In-Reply-To: <20260105175605.52689-1-bruce.richardson@intel.com>
References: <20251210165532.103450-1-bruce.richardson@intel.com>
 <20260105175605.52689-1-bruce.richardson@intel.com>
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

On Mon,  5 Jan 2026 17:55:58 +0000
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
> v2:
> - improve reconnection handling, eliminating some crashes seen in testing.
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
>  usertools/dpdk-telemetry-watcher.py | 435 ++++++++++++++++++++++++++++
>  usertools/meson.build               |   1 +
>  2 files changed, 436 insertions(+)
>  create mode 100755 usertools/dpdk-telemetry-watcher.py
>=20
> --
> 2.51.0

Series-Acked-by: Stephen Hemminger <stephen@networkplumber.org>

Automated patch review reports some things that could be added.



## DPDK Patch Review: Telemetry Watcher (v2, 7 patches)

**Submitter:** Bruce Richardson <bruce.richardson@intel.com> =20
**Series:** [PATCH v2 1-7/7] usertools: add telemetry watcher script

---

### Overall Summary

This is a well-structured patch series adding a new Python script (`dpdk-te=
lemetry-watcher.py`) to monitor DPDK telemetry statistics on the command li=
ne. The series progressively builds up functionality across 7 commits, maki=
ng the series bisectable.

---

### Patch-by-Patch Review

#### **Patch 1/7: usertools: add new script to monitor telemetry on termina=
l**

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 53 characters |
| Lowercase after colon | =E2=9C=85 PASS | |
| Imperative mood | =E2=9C=85 PASS | "add new script" |
| No trailing period | =E2=9C=85 PASS | |
| Signed-off-by | =E2=9C=85 PASS | |
| Body doesn't start with "It" | =E2=9C=85 PASS | Starts with "The" |
| SPDX license | =E2=9C=85 PASS | BSD-3-Clause on line 2 (correct for sheba=
ng script) |
| Copyright line | =E2=9C=85 PASS | |
| Blank line after copyright | =E2=9C=85 PASS | |

**Warning (should fix):**
- **Line 178**: Unnecessary f-string prefix:
  ```python
  print(f"Error: Python interpreter or script not found", file=3Dsys.stderr)
  ```
  Should be:
  ```python
  print("Error: Python interpreter or script not found", file=3Dsys.stderr)
  ```

#### **Patch 2/7: usertools/telemetry-watcher: add displaying stats**

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 47 characters |
| Signed-off-by | =E2=9C=85 PASS | |
| Body wrapping | =E2=9C=85 PASS | Wrapped at 75 chars |

=E2=9C=85 No issues found.

#### **Patch 3/7: usertools/telemetry-watcher: add delta and timeout opts**

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 55 characters |
| Signed-off-by | =E2=9C=85 PASS | |

=E2=9C=85 No issues found.

#### **Patch 4/7: usertools/telemetry-watcher: add total and one-line opts**

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 56 characters |
| Signed-off-by | =E2=9C=85 PASS | |

=E2=9C=85 No issues found.

#### **Patch 5/7: usertools/telemetry-watcher: add thousands separator**

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 51 characters |
| Signed-off-by | =E2=9C=85 PASS | |

=E2=9C=85 No issues found.

#### **Patch 6/7: usertools/telemetry-watcher: add eth name shortcuts**

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 50 characters |
| Signed-off-by | =E2=9C=85 PASS | |

**Info (consider):**
- Line 1124: f-string without interpolation:
  ```python
  print(f"Error: Failed to get ethernet device list", file=3Dsys.stderr)
  ```

#### **Patch 7/7: usertools/telemetry-watcher: support reconnection**

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 48 characters |
| Signed-off-by | =E2=9C=85 PASS | |

**Info (consider):**
- Lines 1243-1244: Dynamically adding attributes to `subprocess.Popen` obje=
ct:
  ```python
  process.script =3D telemetry_script
  process.args =3D args_list
  ```
  This works but could be cleaner using a wrapper class or dataclass to hol=
d the process and its metadata together.

---

### Series-Level Issues

#### **Warning: Missing Documentation**

Per AGENTS.md: *"Code and documentation must be updated atomically in same =
patch"* and *"Documentation must match the code"*

The series adds a new usertool but does not include documentation updates. =
Consider adding:
- Usage documentation in `doc/guides/tools/` describing the new script
- Entry in the tools index

#### **Warning: Missing Release Notes**

Per AGENTS.md: *"New drivers or subsystems must have release notes"* and *"=
Current release notes updated for significant changes"*

A new usertools script should be mentioned in `doc/guides/rel_notes/release=
_XX_XX.rst` under a section like "New Features" or similar.

#### **Info: meson.build List Ordering**

In patch 1/7, the addition to `usertools/meson.build`:
```python
            'dpdk-hugepages.py',
            'dpdk-rss-flows.py',
            'dpdk-telemetry-exporter.py',
+           'dpdk-telemetry-watcher.py',
```

Per AGENTS.md: *"Lists alphabetically ordered"*. The insertion is correctly=
 placed alphabetically between `dpdk-telemetry-exporter.py` and the end. =
=E2=9C=85

---

### Code Quality Observations

**Positive:**
- Clean incremental commits that are individually bisectable
- Good docstrings on functions
- Proper error handling with messages to stderr
- Sensible defaults for optional arguments
- Good use of argparse for CLI handling

**Info (minor suggestions):**
1. The reconnection logic in patch 7/7 could benefit from exponential backo=
ff instead of fixed 1-second retries
2. Consider adding `--help` examples in the epilog of argparse

---

### Summary Table

| Severity | Count | Items |
|----------|-------|-------|
| **Error** | 0 | None |
| **Warning** | 3 | Missing documentation, missing release notes, unnecessa=
ry f-string (1/7 line 178) |
| **Info** | 3 | Unnecessary f-string (6/7), dynamic attribute assignment s=
tyle (7/7), reconnection backoff |

---

### Recommendation

**Acked-by candidate** with minor fixes needed:

1. Remove unnecessary f-string prefix in patch 1/7 line 178
2. Add documentation for the new tool
3. Add release notes entry

The code itself is well-written and the series structure is good. The issue=
s are primarily around the documentation requirements rather than technical=
 problems with the implementation.

