Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A559CD98C5
	for <dpdk-dev@archiver.kernel.org>; Sun, 14 Jun 2026 09:23:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 455EE43663;
	Sun, 14 Jun 2026 11:23:35 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 88C28400D7
 for <dev@dpdk.org>; Sun, 14 Jun 2026 11:23:32 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowABXrtEQcy5qVi9yEw--.28230S2;
 Sun, 14 Jun 2026 17:23:30 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v2 00/20] sxe2: address review comments - testpmd
 restructuring, devargs documentation, and code cleanup
Date: Sun, 14 Jun 2026 17:23:02 +0800
Message-ID: <20260614092328.201826-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260610013936.3634968-21-liujie5@linkdatatechnology.com>
References: <20260610013936.3634968-21-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABXrtEQcy5qVi9yEw--.28230S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AFyxJr43uF1rtFy3CrW7Arb_yoWfZr13pF
 W8C347tas7AayrCw17Xa18WFy5Wa9YkrWUG34UGryIywn0kF1Fyr13Kw4Y9a4UCryUXFy0
 vr4qgF1DCanrA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUk0b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAIw28I
 cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
 IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI
 42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
 IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
 aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUgJDGDUUUU
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

Hi all,

Thank you for the detailed review of the sxe2 PMD patch series. We have
prepared a v2 addressing the feedback. Below is our point-by-point response.

---

### 1. strtoul() out-of-range handling

> This memory stuff looks problematic and needs more review. At a minimum
> I see a pattern of not handling values from strtoul() that are out of range.

After re-examining the devargs parsing code in sxe2_ethdev.c, we confirmed
that the existing parsers handle out-of-range values:

- sxe2_parse_u8(): checks val > UINT8_MAX, returns -ERANGE
- sxe2_parse_bool(): checks bool_val != 0 && bool_val != 1
- sxe2_parse_fnav_stat_type(): checks val > the maximum valid enum value
- sxe2_parse_sched_layer_mode(): checks val > SXE2_TXSCH_NODE_ADJ_LVL_MAX
- sxe2_parse_high_performance_mode(): checks val != 1

Each function sets errno = 0 before strtoul() and checks errno != 0
afterward, which catches ERANGE (overflow). This is followed by a semantic
range check specific to each parameter.

Nevertheless, to make the overflow path more explicit and defensive, we will
add explicit ULONG_MAX comparisons after each strtoul() call in the v2.

---

### 2. testpmd command symbols exported from driver library

> Error: the command logic is placed in sxe2_testpmd_lib.c, compiled into
> the driver library, and exposed through 14 new RTE_EXPORT_EXPERIMENTAL_SYMBOL
> entries. No upstream driver exports symbols for its testpmd commands; all six
> existing drivers with testpmd integration compile their *_testpmd.c into
> testpmd via testpmd_sources and use internal access. These exports are
> vendor public API that any application can link against.

Agreed. This is a valid concern. We will restructure as follows:

- Move the testpmd command implementation from sxe2_testpmd_lib.c into
  sxe2_testpmd.c, compiled via testpmd_sources in the meson build,
  matching the pattern used by i40e, ixgbe, mlx5, bnxt, and others.
- Remove all 14 RTE_EXPORT_EXPERIMENTAL_SYMBOL entries. These were never
  intended as public API.
- Keep driver-internal functions accessible through internal headers only
  (they are already declared in driver-local headers under drivers/net/sxe2/).
- Move application state variables (g_tx_session[][], g_rx_session[][],
  g_esp_header_offset[], g_sess_pool) into the testpmd-side code.

---

### 3. Commands duplicating standard testpmd functionality

> Error: three commands duplicate standard testpmd functionality the driver
> already supports.
> "sxe2 flow rule dump" -> implement the rte_flow dev_dump op
> "sxe2 udp_tunnel_port add|rm" -> port config udp_tunnel_port add|rm
> "sxe2 show stats" -> show port xstats

Agreed on all three:

- **sxe2 flow rule dump**: We will implement the rte_flow_dev_dump() op in
  the driver. After that, the standard "flow dump <port_id> all" command
  works for every application. The private command will be removed.

- **sxe2 udp_tunnel_port add|rm**: This calls rte_eth_dev_udp_tunnel_port_add/
  rm, which is already exposed by "port config <port_id> udp_tunnel_port
  add|rm". The private command is redundant and will be removed.

- **sxe2 show stats**: We will audit the xstats implementation and ensure
  all statistics currently shown by the private formatter are available
  through rte_eth_xstats_get(). Any missing counters will be added as
  xstats entries. The private command will be removed; users will use
  "show port xstats <port_id>" instead.

---

### 4. IPsec SA management suite in testpmd commands

> Warning: the 9-subcommand ipsec suite (egress/ingress add/rm/show,
> session-id and esp-hdr-offset set/get, flush, stats) is an SA management
> application embedded in the driver. Inline crypto is exercised with
> examples/ipsec-secgw, as done for other inline-crypto PMDs.

Understood. We will:

- Remove the ipsec SA management commands from the testpmd extension.
- Document that examples/ipsec-secgw is the supported method for
  exercising inline crypto on this driver, consistent with other
  inline-crypto PMDs (e.g., mlx5, ice).
- If interactive SA management in testpmd is needed in the future,
  we will propose it as generic testpmd commands over rte_security,
  benefiting all drivers equally.

---

### 5. Private devargs

> Warning: seven private devargs are added with no documentation.
> Each surviving devarg needs documentation and a rationale for why
> no standard API covers it.

Documentation has been added to doc/guides/nics/sxe2.rst (Runtime
Configuration section) for all seven devargs, along with
RTE_PMD_REGISTER_PARAM_STRING for discoverability.

Below is the rationale for each devarg that we believe should be retained:

**flow-duplicate-pattern**
This controls whether the hardware switch engine accepts flow rules with
identical match patterns. It does NOT change rte_flow semantics; it
configures a hardware-specific behavior. The switch engine supports two
modes: (a) reject duplicate rules (useful for catching configuration
errors), and (b) allow duplicates by setting a per-rule metadata flag.
This is a hardware capability toggle, analogous to how some NICs support
configurable TCAM overlap behavior. Default value (1 = allow duplicates)
ensures standard rte_flow behavior out of the box. The standard rte_flow
API does not provide a mechanism to control switch-level duplicate rule
behavior.

**fnav-stat-type**
This selects how the Fnav flow engine partitions its hardware counter
resources (packets only, bytes only, or both). This is set at device
initialization and cannot be changed dynamically; it determines the
hardware resource allocation. When only packet counts are needed, the
hardware can allocate the full counter width to packet counting. The
resulting counters are queried via the standard rte_flow_query() API.
No standard API currently exists to select hardware counter resource
allocation mode at initialization time; it is a hardware-specific
configuration decision.

**drv-sw-stats**
Hardware packet statistics counters may be inaccurate for certain packet
types due to hardware design limitations. This devarg enables a software
accumulation path in the Rx data path as a workaround. When enabled, the
driver classifies each received packet (unicast/multicast/broadcast/drop)
and accumulates counts in software. The counters are exposed as xstats
(rx_sw_unicast_packets, etc.). The devarg controls whether the per-packet
software accumulation overhead is incurred; it is an optimization choice
for users who do not require this level of accuracy. The rationale for
keeping this as a devarg rather than always-on xstats is that the
software accumulation adds overhead to the Rx fast path; users who do
not need per-packet classification accuracy should not pay this cost.

**sched-layer-mode**
Different hardware SKUs support different numbers of Tx scheduling levels
(0-3). This parameter caps the maximum scheduling depth at initialization.
This is NOT a TM topology configuration -- the application still builds
its rte_tm hierarchy as usual. Rather, it constrains the hierarchy depth
to match hardware capability across SKU variants. The rte_tm API does not
currently provide a mechanism to query or constrain the maximum scheduling
depth before configuring the hierarchy, so a devarg is the practical
approach.

**high-performance-mode**
When enabled, the Tx path bypasses the hardware scheduling module and
sends packets directly to the port. This trades TM scheduling capability
for lower latency and higher throughput. It is not appropriate to make
this the default because TM functionality is important for many users.
The devarg (now documented) makes the performance trade-off explicit.

**rx-low-latency**
Controls whether Rx interrupt moderation is tuned for minimum latency vs.
batching efficiency. This is a hardware-specific tuning parameter with
no equivalent in the standard Ethdev API. Many drivers have analogous
low-latency devargs (e.g., mlx5 has rxqs_min_bth for similar purposes).

**function-flow-direct**
Controls whether flow rules can directly target a specific PF/VF function.
This is a hardware switch engine feature that affects the scope of flow
redirection. The standard rte_flow API does not have a per-rule flag for
this; the devarg controls the default redirect behavior.

---

### Summary of changes for v2

1. Add explicit ULONG_MAX checks after strtoul() in all devarg parsers
2. Move testpmd command implementation out of driver library into
   testpmd_sources; remove all 14 RTE_EXPORT_EXPERIMENTAL_SYMBOL
3. Implement rte_flow_dev_dump op; remove "sxe2 flow rule dump" command
4. Remove "sxe2 udp_tunnel_port add|rm" command (redundant)
5. Add missing counters to xstats; remove "sxe2 show stats" command
6. Remove ipsec SA management testpmd commands
7. Retain 7 devargs with documentation and rationale in sxe2.rst
8. Add RTE_PMD_REGISTER_PARAM_STRING for all devargs

We will send v2 shortly. Please let us know if there are any further
concerns.

Thanks,
[sender name]

